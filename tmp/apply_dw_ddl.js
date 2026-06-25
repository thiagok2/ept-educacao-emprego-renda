const fs = require('fs');
const { Client } = require('pg');

const mcp = JSON.parse(fs.readFileSync('.mcp.json', 'utf8'));
const args = mcp?.mcpServers?.postgres?.args;
if (!args || args.length === 0) {
  console.error('No postgres args found');
  process.exit(1);
}
const connString = args[args.length - 1];
const sqlFile = 'tmp/dw_ept_restructure.sql';
const content = fs.readFileSync(sqlFile, 'utf8');
const marker = '-- Load data into DW tables';
const idx = content.indexOf(marker);
if (idx === -1) {
  console.error('Marker not found in SQL file');
  process.exit(1);
}
const ddl = content.slice(0, idx).trim() + '\nCOMMIT;\n';

console.log('Executing DDL from', sqlFile);
const client = new Client({ connectionString: connString });

(async () => {
  try {
    await client.connect();
    await client.query(ddl);
    console.log('DDL executed successfully');
  } catch (err) {
    console.error('DDL execution failed:');
    console.error(err);
    process.exit(1);
  } finally {
    await client.end();
  }
})();
