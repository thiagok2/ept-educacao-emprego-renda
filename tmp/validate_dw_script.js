const fs = require('fs');
const { Client } = require('pg');
const scriptFile = process.argv[2];
const config = JSON.parse(fs.readFileSync('.mcp.json', 'utf8'));
const args = config.mcpServers.postgres.args;
const connString = args[args.length - 1];
const script = fs.readFileSync(scriptFile, 'utf8')
  .replace(/^\s*BEGIN;\s*/i, '')
  .replace(/\s*COMMIT;\s*$/i, '');
const client = new Client({ connectionString: connString });
(async () => {
  try {
    await client.connect();
    await client.query('BEGIN');
    await client.query(script);
    await client.query('ROLLBACK');
    console.log('VALIDATION_OK');
    await client.end();
  } catch (err) {
    console.error(err);
    try { await client.query('ROLLBACK'); } catch (_) {}
    await client.end();
    process.exit(1);
  }
})();
