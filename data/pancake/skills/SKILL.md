---
name: pancake
description: This tool manages the development lifecycle and core features of the PancakeSwap frontend monorepo. Use when user asks to start the development server, build specialized application modules like the Aptos dApp, or utilize internal SDKs for trade routing and smart contract interactions.
homepage: https://github.com/pancakeswap/pancake-frontend
---


# pancake

## Overview
The PancakeSwap frontend is a complex monorepo built with TypeScript, pnpm, and Turborepo. This skill provides the necessary procedural knowledge to manage the development lifecycle of the platform's core features, including farms, pools, IFOs, and the lottery. It streamlines the process of launching specific application modules and utilizing internal SDKs for smart contract interactions.

## Development Commands
The project uses `pnpm` for package management. Ensure you are in the root directory before executing commands.

### Core Web Application
- **Install Dependencies**: `pnpm i`
- **Start Development Server**: `pnpm dev`
- **Production Build**: `pnpm build`
- **Run Production Build**: `pnpm start`

### Specialized Applications
Use the following scripts to target specific modules within the monorepo:
- **Aptos dApp**: `pnpm dev:aptos` / `pnpm build:aptos`
- **Blog**: `pnpm dev:blog` / `pnpm build:blog`
- **Games**: `pnpm dev:games` / `pnpm build:games`

## Working with SDKs
The repository contains several specialized SDKs in the `packages/` directory. When building features, leverage these instead of writing custom logic:
- **@pancakeswap/smart-router**: Use for fetching optimal trade routes.
- **@pancakeswap/v3-sdk**: Use for building on top of PancakeSwap V3 liquidity.
- **@pancakeswap/multicall**: Use for batching blockchain calls to stay within gas limits.
- **@pancakeswap/wagmi / awgmi**: Use for wallet connections on EVM and Aptos respectively.

## Best Practices
- **Dependency Management**: Always use `pnpm`. Avoid `npm` or `yarn` to prevent lockfile conflicts and ensure workspace integrity.
- **Task Orchestration**: The project uses `turbo`. You can run tasks across the entire monorepo or target specific workspaces using the `--filter` flag.
- **Environment Configuration**: Ensure `.env` files are correctly configured in the respective `apps/` folders before starting the development servers.
- **Testing**: Use Cypress for end-to-end testing as integrated within the `apps/web` directory.

## Reference documentation
- [Pancake Frontend README](./references/github_com_pancakeswap_pancake-frontend.md)