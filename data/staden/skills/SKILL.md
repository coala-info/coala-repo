---
name: staden
description: Staden is a specialized outliner tool designed to provide a Logseq-inspired workflow for managing markdown notes.
homepage: https://github.com/oshikiri/staden-outliner
---

# staden

## Overview
Staden is a specialized outliner tool designed to provide a Logseq-inspired workflow for managing markdown notes. Built on a modern stack of TypeScript, Next.js, and SQLite, it allows for structured data management through SQLite table queries within a plaintext outliner interface. This skill assists in the technical orchestration of the Staden environment, covering workspace setup, API-driven initialization, and application lifecycle management.

## Environment Configuration
The application requires a defined root directory where markdown files and data will be stored.

- **Set the Workspace Root**: Define the `STADEN_ROOT` environment variable before starting the server.
  ```bash
  export STADEN_ROOT=/path/to/your/markdown/docs
  ```

## Initialization and Setup
Before the outliner is functional, the internal API must be triggered to prepare the environment.

1. **Start the Server**: Run the development server.
   ```bash
   npm run dev
   ```
2. **Initialize the API**: In a separate terminal, use `curl` to trigger the initialization endpoint. This step is required to set up the database and file structures.
   ```bash
   curl http://localhost:3000/api/initialize
   ```
3. **Access the Interface**: Once initialized, navigate to `http://localhost:3000/pages/index` in a web browser.

## Development Workflows

### Local Node.js Development
Standard commands for managing the TypeScript/Next.js environment:
- **Install Dependencies**: `npm install`
- **Run Development Server**: `npm run dev`
- **Linting**: `npm run lint`
- **Production Build**: `npm run build`
- **Start Production Server**: `npm run start`

### Docker Integration
For containerized environments, use the provided Docker Compose configuration:
- **Build and Run**: `docker compose up --build app`
- **Stop Services**: `docker compose down`

## Expert Tips
- **SQLite Queries**: Staden supports querying tables using SQLite. Ensure your markdown files follow the expected schema to leverage the query table features.
- **Image Support**: The tool supports pasting images directly from the clipboard, which are stored within the defined `STADEN_ROOT`.
- **Path Handling**: When troubleshooting API issues, verify that `STADEN_ROOT` is an absolute path or correctly relative to the execution context to avoid "wrong path" errors in the images API.

## Reference documentation
- [Staden Outliner README](./references/github_com_oshikiri_staden-outliner.md)