---
name: pancake
description: The pancake tool manages the PancakeSwap frontend monorepo and processes genomic data objects. Use when user asks to start development servers, build production applications, manage internal SDKs, or extract core genome regions from PanCake data files.
homepage: https://github.com/pancakeswap/pancake-frontend
---

# pancake

## Overview
The pancake skill is designed to help agents navigate and manage the PancakeSwap frontend monorepo. This project is a complex TypeScript-based environment using pnpm and Turbo to manage multiple decentralized finance (DeFi) applications and supporting SDKs. Use this skill to identify the correct commands for starting development servers, building production bundles, and understanding the architecture of the various packages like the Smart Router and Multicall SDKs.

## Development Workflow

### Environment Setup
The project uses `pnpm` as the primary package manager. Ensure dependencies are installed before running any application:
```bash
pnpm i
```

### Running Sub-Applications
The monorepo contains several distinct applications. Use the following commands from the root directory to target specific apps:

*   **Main Web App**: The primary PancakeSwap interface.
    *   Development: `pnpm dev`
    *   Build: `pnpm build`
    *   Production Start: `pnpm start`
*   **Aptos App**: Frontend specifically for the Aptos network.
    *   Development: `pnpm dev:aptos`
    *   Build: `pnpm build:aptos`
*   **Blog**: The PancakeSwap blog platform.
    *   Development: `pnpm dev:blog`
    *   Build: `pnpm build:blog`
*   **Games**: The gaming platform frontend.
    *   Development: `pnpm dev:games`
    *   Build: `pnpm build:games`

## Package Architecture
When implementing features, leverage the internal packages located in the `packages/` directory:

*   **smart-router**: Use this SDK for calculating the most efficient trade routes across liquidity pools.
*   **multicall**: Use this to batch multiple blockchain calls into a single transaction to stay within gas limits and improve performance.
*   **v3-sdk**: Essential for building features on top of PancakeSwap V3 liquidity positions.
*   **wagmi / awgmi**: Use these for wallet connectors and React hooks (wagmi for EVM chains, awgmi for Aptos).

## Localization and Translations
PancakeSwap uses a centralized localization system integrated with Crowdin.

1.  **Adding Strings**: New translation keys must be added to the master file: `src/config/localization/translations.json`.
2.  **Syncing**: Once merged into the `develop` branch, the Crowdin integration automatically detects changes and generates PRs for supported languages.
3.  **Output**: Translated files are generated at `public/locales/[locale].json`.

## Best Practices
*   **Monorepo Management**: Always run commands from the root using `pnpm` to ensure Turbo handles caching and task orchestration correctly.
*   **Type Safety**: The project is strictly TypeScript. Ensure all new components and hooks are properly typed using the internal SDKs.
*   **Testing**: Use Cypress for end-to-end testing as defined in the project structure.



## Subcommands

| Command | Description |
|---------|-------------|
| pancake core | Identify and extract core genome regions from a PanCake Data Object File. |
| pancake create | Create a PanCake Object from sequences and alignments |
| pancake graph | Generate a DOT graph from PanCake Data Object Files |
| pancake sequence | Extract sequences from PanCake Data Object Files |
| pancake singletons | Identify singleton regions in a PanCake Data Object File and output them as FASTA or BED files. |
| pancake specify | Specify or modify chromosome information in a PanCake Data Object File |
| pancake status | Check the status of a PAN_FILE |

## Reference documentation
- [Pancake Frontend Overview](./references/github_com_pancakeswap_pancake-frontend.md)
- [Localization and Translations Workflow](./references/github_com_pancakeswap_pancake-frontend_wiki_Translations.md)