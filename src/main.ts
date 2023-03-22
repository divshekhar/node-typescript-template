#!/usr/bin/env node

import express, { Request, Response } from 'express';
import 'dotenv/config';
import { Config } from './config';

const app = express();
const PORT = Config.port;

app.get('/', (_: Request, res: Response) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.send('Hello world');
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

export default app;
