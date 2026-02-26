---
name: glimmer
description: Glimmer is a high-performance rendering pipeline that uses a virtual machine to efficiently create and update the DOM using Handlebars templates. Use when user asks to build the Glimmer VM, run browser or Node.js tests, link local packages, or implement internal TypeScript patterns using indexed access syntax.
homepage: https://github.com/glimmerjs/glimmer-vm
---


# glimmer

## Overview
Glimmer is a high-performance, low-level rendering pipeline designed to create and update the DOM efficiently using Handlebars templates. It functions as a virtual machine that executes compiled bytecode to manage "live" DOM updates. This skill facilitates development within the Glimmer VM ecosystem, covering the lifecycle from installation and building to specialized internal coding conventions required for the engine's architecture.

## Development Workflow

### Environment Setup
Ensure Node.js is installed before managing dependencies.
- **Install dependencies**: `pnpm install` (or `npm install`/`yarn install`)
- **Build packages**: `npm run build`
  - Note: Builds are placed in the `dist/` directory.
  - Production builds require `ember build --env production` or `npm run build`. Standard builds may only contain test assets.

### Testing Procedures
Glimmer uses a multi-environment testing strategy:
- **Full Suite**: `pnpm test`
- **Node.js Environment**: `pnpm test:node` (utilizes Turbo for execution)
- **Browser Environment**: 
  1. Run `pnpm start` to launch the Vite dev server.
  2. Navigate to the provided local URL.
  3. Use the QUnit interface to filter and execute specific test modules.

### Package Linking
To use locally built Glimmer packages in other projects:
1. Build the packages first.
2. Run `npm run yarn:link` to execute `yarn link` inside each built package directory.

## TypeScript Best Practices

### Internal "Friend" Properties
Glimmer uses a specific pattern for properties that must be shared across internal packages but should not be part of the public API.
- **Pattern**: Mark the property as `private` or `protected`.
- **Access**: Use the `['property']` indexed access syntax to bypass standard visibility checks within the same package or internal protocol.
- **Example**:
  ```typescript
  class Layout {
    private template: Template;
  }

  function compile(layout: Layout, environment: Environment) {
    // Accessing private property via indexed syntax for internal protocol
    return layout['template'].compile(environment);
  }
  ```
- **Guideline**: Do not use this syntax to access private properties outside of the intended internal package scope.

## Maintenance Note
As of January 2026, the Glimmer VM repository has been archived and merged into the main `ember.js` repository. New features or bug fixes should be directed toward the `ember-source` packages in the Ember.js codebase.

## Reference documentation
- [Glimmer VM README](./references/github_com_glimmerjs_glimmer-vm.md)