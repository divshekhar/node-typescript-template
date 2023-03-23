#!/usr/bin/env node

import express, { Request, Response } from 'express';
import 'dotenv/config';
import { Config } from './config';

import { resolve } from 'path';
import { fileURLToPath } from 'url';

const app = express();
const PORT = Config.port;

app.get('/', (_: Request, res: Response) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.send('Hello world');
});

// Node path to the current file
const nodePath = resolve(process.argv[1]);

// Module path to the current file
const modulePath = resolve(fileURLToPath(import.meta.url));

const isCLI = nodePath === modulePath;
// Only start the server if the script is run directly
if (isCLI) {
  app.listen(PORT, () => {
    // eslint-disable-next-line no-console
    console.log(`Server is running on port ${PORT}`);
  });
}

export default app;
