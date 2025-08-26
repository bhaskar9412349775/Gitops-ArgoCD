const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const version = process.env.APP_VERSION || 'v1';

app.get('/', (req, res) => {
  res.send(`Hello from GitOps demo! Version: ${version}\n`);
});

app.get('/healthz', (req, res) => res.send('ok'));

app.listen(port, () => {
  console.log(`App listening on port ${port} (version: ${version})`);
});
