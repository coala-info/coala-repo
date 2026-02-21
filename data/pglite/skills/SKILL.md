---
name: pglite
description: PGlite is a specialized build of PostgreSQL compiled to WebAssembly, allowing it to function as a client-side or embedded library.
homepage: https://github.com/electric-sql/pglite
---

# pglite

## Overview

PGlite is a specialized build of PostgreSQL compiled to WebAssembly, allowing it to function as a client-side or embedded library. Unlike other "Postgres in the browser" solutions that rely on heavy Linux emulators, PGlite runs the database engine natively within the JavaScript runtime. This makes it an excellent choice for local-first applications, reactive web interfaces, and lightweight testing environments where SQL compliance is required but a traditional server architecture is impractical. It supports standard SQL queries, persistence to disk or IndexedDB, and common Postgres extensions.

## Implementation Patterns

### Initialization and Persistence

PGlite can be initialized as an ephemeral in-memory database or a persistent store depending on the connection string provided to the constructor.

- **In-Memory (Ephemeral):**
  ```javascript
  import { PGlite } from "@electric-sql/pglite";
  const db = new PGlite();
  ```

- **Filesystem Persistence (Node.js / Bun / Deno):**
  ```javascript
  const db = new PGlite("./path/to/pgdata");
  ```

- **Browser Persistence (IndexedDB):**
  ```javascript
  const db = new PGlite("idb://my-database-name");
  ```

### Executing Queries

The `query` method is the primary interface for interacting with the database. It returns a result object containing the rows and metadata.

```javascript
const result = await db.query(
  "SELECT * FROM users WHERE id = $1",
  [123]
);
console.log(result.rows);
```

### Extension Support

PGlite supports several Postgres extensions, including `pgvector`. These must be imported and passed during initialization if they are not part of the core WASM bundle.

## Expert Tips and Constraints

- **Single User Limitation:** PGlite is strictly single-user and single-connection. It is not designed to replace a multi-user production database server but rather to act as a local or embedded engine.
- **Bundle Size:** The core library is approximately 3MB gzipped, making it highly portable for web applications.
- **No Forking:** Because WASM environments (via Emscripten) do not support process forking, PGlite operates in Postgres's "single user mode" internally.
- **Reactive Bindings:** Use PGlite in conjunction with reactive frameworks (like the official React or Vue bindings) to trigger UI updates automatically when the underlying data changes.

## Reference documentation

- [PGlite Main Repository](./references/github_com_electric-sql_pglite.md)
- [PGlite Documentation Index](./references/github_com_electric-sql_pglite_tree_main_docs.md)