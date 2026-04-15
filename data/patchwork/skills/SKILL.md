---
name: patchwork
description: Patchwork is a decentralized peer-to-peer messaging and social sharing application built on the Secure Scuttlebutt protocol. Use when user asks to install the software, join a pub to discover peers, or troubleshoot technical issues within the legacy SSB environment.
homepage: https://github.com/ssbc/patchwork
---

# patchwork

## Overview
Patchwork is a decentralized, peer-to-peer messaging and social sharing application built on the Secure Scuttlebutt (SSB) protocol. It allows users to communicate without central servers, syncing data directly with peers over local networks or through "pubs." While the project was archived in May 2021, this skill provides the necessary procedures for installation, network onboarding, and technical troubleshooting for legacy environments.

## Installation and Setup
Patchwork can be installed via several package managers. Note that as an archived project, newer versions of Node.js may encounter compatibility issues.

- **NPM**: `npm install --global ssb-patchwork`
- **Yarn**: `yarn global add ssb-patchwork`
- **Homebrew (macOS)**: `brew cask install patchwork`
- **Arch Linux**: `yay -S ssb-patchwork`

## Onboarding Workflow
To participate in the decentralized network, users must connect to a "pub" to discover other peers.

1. **Obtain an Invite**: Locate a pub (e.g., from a community pub list) and copy the invite code.
2. **Redeem Invite**: Within the Patchwork interface, select **Join Pub**.
3. **Authentication**: Paste the invite code and select **Redeem Invite**.
4. **Discovery**: Use the `#new-people` hashtag to find active users and begin syncing the ledger.

## Technical Architecture and Constraints
When working with the Patchwork codebase or troubleshooting its behavior, be aware of its bespoke architectural decisions:

- **Dependency Injection**: Uses `depject`, a custom system that can make standard code navigation and debugging difficult.
- **Observables**: Uses `mutant` for state management and HTML generation rather than standard frameworks like React.
- **Database**: Deeply integrated with `ssb-db` (the original SSB stack) and includes custom plugins. It is not natively compatible with the newer `ssb-db2`.
- **Bundled Server**: Patchwork runs its own bundled `ssb-server` (sbot) and generally does not work with external SSB server instances.

## Expert Tips
- **Archival Warning**: Patchwork is no longer maintained. For production use or better security, consider migrating to active clients like Manyverse or Oasis.
- **Data Persistence**: All messages are stored locally on the device. Ensure you back up your `.ssb` directory (specifically the `secret` file) to retain your identity.
- **Offline Usage**: Patchwork is fully functional offline; messages will queue and sync automatically once a connection to a peer or pub is established.

## Reference documentation
- [ssbc/patchwork README](./references/github_com_ssbc_patchwork.md)