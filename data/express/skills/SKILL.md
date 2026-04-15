---
name: express
description: Express is a minimalist web framework for Node.js used to build web applications and HTTP APIs. Use when user asks to create a web server, set up modular routing, integrate middleware, or build RESTful services.
homepage: https://github.com/expressjs/express
metadata:
  docker_image: "quay.io/biocontainers/express:1.5.1--h2d50403_1"
---

# express

## Overview

Express is the standard minimalist web framework for Node.js, designed to provide a thin layer of fundamental web application features without obscuring Node.js features. It is primarily used to build single-page applications, websites, hybrids, or public HTTP APIs. This skill enables the efficient setup of server-side logic, modular routing, and the integration of various template engines and middleware.

## Quick Start and Scaffolding

The fastest way to initialize a structured Express application is using the official generator.

### Using Express Generator
To create a project structure with a specific template engine:
```bash
# Install the generator globally or use npx
npx express-generator --view=pug my-app

# Navigate and install dependencies
cd my-app
npm install

# Start the application (with debug logging)
DEBUG=my-app:* npm start
```

## Core Implementation Patterns

### Basic Server Structure
```javascript
import express from 'express'
const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.send('Hello World')
})

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`)
})
```

### Modular Routing
For large applications, use `express.Router` to categorize routes into separate files.
```javascript
// routes/users.js
import express from 'express'
const router = express.Router()

router.get('/:id', (req, res) => {
  res.json({ user: req.params.id })
})

export default router

// app.js
import userRouter from './routes/users.js'
app.use('/users', userRouter)
```

## Expert Tips and Best Practices

### Middleware Execution Order
Middleware functions are executed sequentially. Always place general-purpose middleware (like logging or body parsing) before specific route handlers.
- **Error Handling**: Define error-handling middleware last, after all other `app.use()` and route calls. It must have four arguments: `(err, req, res, next)`.

### Express v5 Migration Highlights
If working with or migrating to Express v5:
- **Path Syntax**: The path-to-regexp library has been updated; check for changes in wildcard (`*`) and parameter matching.
- **Rejected Promises**: Express 5 now automatically handles rejected promises in route handlers and middleware, passing them to the error handler without requiring a manual `try/catch` or `next(err)`.
- **Methods**: Some methods like `res.sendfile` (camelCase) have been removed in favor of `res.sendFile`.

### Performance and Security
- **Environment**: Always set `NODE_ENV=production` to enable view caching and less verbose error messages.
- **Security**: Use the `helmet` middleware to set various HTTP headers for security.
- **Body Parsing**: Use the built-in `express.json()` and `express.urlencoded({ extended: true })` instead of the legacy standalone `body-parser` package where possible.

## Reference documentation
- [Express README](./references/github_com_expressjs_express.md)
- [Express Wiki (Migration & Patterns)](./references/github_com_expressjs_express_wiki.md)
- [Security Policies](./references/github_com_expressjs_express_security.md)