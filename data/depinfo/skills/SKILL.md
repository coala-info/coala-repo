---
name: depinfo
description: The depinfo tool manages the creation and deployment of standardized educational websites using a specialized Docusaurus template. Use when user asks to initialize a course repository, configure GitHub Pages deployment, set up a local development environment, or manage Markdown content with custom departmental components.
homepage: https://github.com/departement-info-cem/depinfo-gabarit
---


# depinfo

## Overview
The depinfo skill provides a standardized workflow for generating and managing educational websites. It utilizes a specialized Docusaurus template to convert Markdown documentation into a structured, hosted site. This skill ensures adherence to departmental standards, such as specific repository naming conventions and automated deployment configurations, while providing guidance on local environment setup and custom component usage.

## Setup and Configuration
- **Repository Initialization**: Fork the `depinfo-gabarit` repository. Use the departmental naming standard: `sigle-nom-du-cours` (e.g., `4N6-Mobile`).
- **Core Configuration**: Modify `config.json` in the root directory. Ensure the `nomUrl` field exactly matches your GitHub repository name to ensure correct path routing.
- **GitHub Pages Setup**: In the repository Settings > Pages, set the "Build and deployment" source to "GitHub Actions".
- **Enable Workflows**: Navigate to the "Actions" tab and manually accept the terms to allow the deployment script to run.

## Local Development
- **Environment Setup**: Ensure NodeJS and NPM are installed on the local machine.
- **Installation**: Navigate to the web directory to manage dependencies.
  ```bash
  cd web
  npm install
  ```
- **Execution**: Start the development server to preview changes in real-time.
  ```bash
  npm start
  ```
- **Hot Reloading**: Changes made to files in the `/docs` directory will refresh automatically. Changes to `docusaurus.config.js` require a manual restart of the npm process.

## Content Management
- **Markdown Authoring**: Place all course content in the `/docs` directory using Markdown (.md) or MDX (.mdx) files.
- **Custom Components**: Utilize specialized React components developed for the department, such as `GHCode`, `Video`, `DocsViewer`, and layout tools like `Row` and `Column`.
- **Updates**: Synchronize your fork with the upstream `depinfo-gabarit` at least once per year to receive the latest features and security patches.

## Deployment
- **Automated Publishing**: Every push to the `main` branch triggers a GitHub Action that builds and deploys the site.
- **URL Structure**: The site will be accessible at `https://info.cegepmontpetit.ca/[repo-name]/`.

## Reference documentation
- [Main README](./references/github_com_departement-info-cem_depinfo-gabarit.md)
- [Wiki Home](./references/github_com_departement-info-cem_depinfo-gabarit_wiki.md)