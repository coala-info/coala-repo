---
name: sofa-apps
description: This tool provides procedural knowledge for developing, building, and deploying applications within the CouchCommerce framework. Use when user asks to set up the development environment, manage dependencies with Bower, execute Grunt build tasks, or follow the release and deployment workflow.
homepage: https://github.com/sofa/app
---


# sofa-apps

## Overview
The sofa-apps skill provides procedural knowledge for working with the CouchCommerce application framework. It guides users through the legacy web development stack required for Sofa apps, including dependency management with Bower and task automation via Grunt. Use this skill to ensure correct build sequences, handle Selenium-based testing requirements, and follow the specific versioning and deployment workflows required for this ecosystem.

## Environment Setup
Before running the application, ensure the following global dependencies are installed:
- Node.js and npm
- Bower
- Karma
- Compass
- Protractor
- Java (required for Selenium/Protractor)

### Installation Sequence
1. Clone the repository.
2. Install Node dependencies: `npm install`
3. Install frontend components: `bower install`

## Development and Testing
Sofa apps rely on a running Selenium server for initial builds and end-to-end (e2e) testing.

### Starting the Application
1. **Start Selenium**: Run `webdriver-manager start` (provided by Protractor).
2. **Launch Development Mode**: Run `grunt watch`.
   - This executes the build and delta tasks.
   - The app is served at `http://localhost:9000`.
   - Sub-targets re-run automatically when file changes are detected.

## Build and Deployment Tasks
Use the following Grunt patterns for different environments:

- **Development Build**: `grunt build`
  Generates a version of the app suitable for browser testing.
- **Production Compilation**: `grunt compile`
  Creates a production-ready package with uglified JavaScript.
- **Debug Compilation**: `grunt compile-debug`
  Same as compile, but preserves readable JavaScript.
- **Deployment**: `grunt deploy --app-version=<VERSION>`
  Deploys the application. Use the `--app-version` flag to specify the release version (e.g., `0.50.0`).

## Release Workflow
To maintain version control integrity, follow this specific sequence when updating dependencies or cutting a release:

1. **Update Sofa Dependencies**:
   - Run `grunt` in the specific sofa component to produce distribution files.
   - Generate logs: `grunt changelog`.
   - Update `package.json` and `bower.json` following SemVer.
   - Tag the version: `git tag <VERSION>`.
   - Publish: `npm publish`.

2. **Update the Main App**:
   - Update `package.json` to reference the new dependency versions.
   - Commit changes with the message: `chore(package.json): updating dependencies`.
   - Execute the deployment: `grunt deploy --app-version=<VERSION>`.

## Configuration
Application-specific settings are managed in `build.config.js`. Modify this file to adjust build paths, included files, or environment-specific variables.

## Reference documentation
- [CouchCommerce App README](./references/github_com_sofa_app.md)