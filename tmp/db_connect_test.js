const fs = require('fs');
const { Client } = require('pg');

const mcp = JSON.parse(fs.readFileSync('.mcp.json', 'utf8'));
const args = mcp?.mcpServers?.postgres?.args;
if (!args || args.length === 0) {
  console.error('No postgres args found');
  process.exit(1);
}
const connString = args[args.length - 1];
console.log('Using connection string:', connString);
const client = new Client({ connectionString: connString });

client.connect()
  .then(() => client.query("SELECT current_database() AS db, current_user AS user, version() AS version, count(*) AS staging_tables FROM information_schema.tables WHERE table_schema='staging'"))
  .then(res => {
    console.log(JSON.stringify(res.rows, null, 2));
    return client.end();
  })
  .catch(err => {
    console.error(err);
    process.exit(1);
  });
