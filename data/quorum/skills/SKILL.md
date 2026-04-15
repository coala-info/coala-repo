---
name: quorum
description: GoQuorum is a permissioned implementation of the Ethereum protocol that provides data privacy and alternative consensus mechanisms for enterprise use cases. Use when user asks to initialize a node, configure QBFT or Raft consensus, enable private transactions via a Private Transaction Manager, or implement node-level permissioning.
homepage: https://github.com/Consensys/quorum
metadata:
  docker_image: "biocontainers/quorum:v1.1.1-2-deb_cv1"
---

# quorum

## Overview
GoQuorum is a permissioned implementation of the Ethereum protocol designed for enterprise use cases. It is a fork of `go-ethereum` (geth) that introduces two primary enhancements: data privacy and alternative consensus mechanisms. It allows for "Public" state (visible to all) and "Private" state (visible only to authorized participants). Use this skill to navigate the specific CLI requirements for Quorum's consensus engines and its integration with Private Transaction Managers (PTM).

## Core CLI Patterns and Best Practices

### Network Initialization
GoQuorum uses a modified genesis file to support its consensus mechanisms.
*   **Initialize a node**: Use the standard geth command with your Quorum-specific genesis file.
    `geth --datadir path/to/datadir init genesis.json`

### Consensus Configuration
GoQuorum replaces Proof of Work with several pluggable consensus engines. You must specify the consensus type during node startup.

*   **QBFT (Recommended)**: The current standard for enterprise BFT.
    `geth --istanbul --istanbul.blockperiod 5 --mine --miner.threads 1`
*   **Raft**: Used for faster block times and on-demand block creation.
    `geth --raft --raftport 50400 --rpc --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,raft`
*   **IBFT (Istanbul BFT)**: A PBFT-inspired consensus.
    `geth --istanbul --mine`

### Privacy Integration (Tessera)
To enable private transactions, GoQuorum must communicate with a Private Transaction Manager (like Tessera) via a Unix Socket or IPC.

*   **Enable Privacy**: Use the `--ptm.socket` flag to point to the Tessera `.ipc` file.
    `geth --ptm.socket /path/to/tessera.ipc`
*   **Private Transactions**: When sending transactions via RPC, use `st.sendTransaction` with the `privateFor` or `privacyGroupId` parameters to specify recipients.

### Node Permissioning
GoQuorum supports node-level permissioning to ensure only authorized peers join the network.
*   **Enable Permissioning**: Use the `--permissioned` flag. This requires a `permissioned-nodes.json` file in the `<datadir>` containing the enode URLs of authorized peers.
    `geth --datadir path/to/datadir --permissioned`

### Security and Maintenance
*   **Vulnerability Check**: Use the built-in version check to cross-reference the current binary against known security issues.
    `geth version-check`
*   **Account Management**: GoQuorum supports account plugins for external vaults. Use the `--plugins` flag to extend account management capabilities.

## Expert Tips
*   **Quickstart Tool**: For development environments, use the `quorum-dev-quickstart` utility to generate a local docker-based network in minutes.
*   **Raft Block Creation**: In Raft mode, blocks are only minted when a transaction is submitted, which saves disk space and processing power in low-volume environments.
*   **Privacy Separation**: Remember that a "Private" transaction is only stored in the private state of the participants. The public blockchain only stores a hash of the encrypted payload.

## Reference documentation
- [GoQuorum README](./references/github_com_Consensys_quorum.md)
- [GoQuorum Wiki](./references/github_com_Consensys_quorum_wiki.md)
- [Security Policy](./references/github_com_Consensys_quorum_security.md)