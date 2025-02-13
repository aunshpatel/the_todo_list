import express from "express";
import path from "path";
import logger from "morgan";
import dotenv from 'dotenv';
// const logger = require('morgan');
import './config/database.js';
import { fileURLToPath } from 'url';

dotenv.config();
// Connect to the database

const app = express();

app.use(logger('dev'));
app.use(express.json());

// Configure both serve-favicon & static middleware
// to serve from the production 'build' folder
// app.use(favicon(path.join(__dirname, 'build', 'favicon.ico')));
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

app.use(express.static(path.join(__dirname, 'build')));

// Middleware to check and verify a JWT and
// assign the user object from the JWT to req.user

const port = process.env.PORT || 3001;

// Put API routes here, before the "catch all" route
// app.use('/api/users', require('./routes/api/users'));

// app.use('/api/todos', require('./routes/api/todos'));

// The following "catch all" route (note the *) is necessary
// to return the index.html on all non-AJAX/API requests
app.get('/*', function(req, res) {
  res.sendFile(path.join(__dirname, 'build', 'index.html'));
});

app.listen(port, function() {
  console.log(`Express app running on port ${port}`);
});
