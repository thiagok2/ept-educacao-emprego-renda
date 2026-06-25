const fs = require('fs');
const { Client } = require('pg');

const mcp = JSON.parse(fs.readFileSync('.mcp.json', 'utf8'));
const args = mcp?.mcpServers?.postgres?.args;
if (!args || args.length === 0) {
  console.error('No postgres args found');
  process.exit(1);
}
const connString = args[args.length - 1];
const sqlFile = 'tmp/dw_corrections.sql';
let content = fs.readFileSync(sqlFile, 'utf8');
content = content.replace(/^\uFEFF/, '');
// remove lines that are pure comments
const lines = content.split(/\r?\n/).filter(l=>!l.trim().startsWith('--'));
const cleaned = lines.join('\n');
const stmts = cleaned.split(';').map(s=>s.trim()).filter(s=>s.length>0);

(async ()=>{
  const client = new Client({ connectionString: connString });
  try{
    await client.connect();
    console.log('Connected. Executing', stmts.length, 'statements');
    for (let i=0;i<stmts.length;i++){
      const sql = stmts[i];
      console.log('\n-- Statement', i+1,'--');
      console.log(sql.slice(0,200));
      try{
        const res = await client.query(sql);
        if (res && res.command === 'SELECT'){
          console.log('SELECT rows:', res.rows.length, res.rows[0]);
        } else if (res && res.rowCount !== undefined){
          console.log(res.command, 'affected rows:', res.rowCount);
        } else {
          console.log('Executed');
        }
      }catch(err){
        console.error('Error executing statement', i+1, err.message);
        await client.end();
        process.exit(1);
      }
    }
    await client.end();
    console.log('\nAll statements executed successfully');
  }catch(e){
    console.error(e);
    process.exit(1);
  }
})();
