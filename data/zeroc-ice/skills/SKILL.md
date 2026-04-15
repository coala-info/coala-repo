---
name: zeroc-ice
description: ZeroC Ice is an RPC framework for building networked applications. Use when user asks to create networked applications, compile IDL definitions, deploy or monitor servers, implement publish-subscribe messaging, secure client-server communication, or monitor application performance.
homepage: https://github.com/zeroc-ice
metadata:
  docker_image: "quay.io/biocontainers/zeroc-ice:3.7.1--py35hd0a1c67_0"
---

# zeroc-ice

## Overview
ZeroC Ice (Internet Communications Engine) is a comprehensive RPC framework designed to simplify the creation of networked applications. It allows developers to focus on application logic by handling low-level network tasks such as connection management, serialization, and retries. The framework is centered around the Slice (Specification Language for Ice) IDL, which defines the contract between clients and servers across different programming languages.

## Installation
To set up the Ice environment, use one of the following package managers:

- **Conda (Bioconda):**
  ```bash
  conda install bioconda::zeroc-ice
  ```
- **Homebrew (Nightly Builds):**
  ```bash
  brew install zeroc-ice/nightly/ice
  ```

## Core Workflow: Slice Compilation
The primary development step involves compiling Slice definitions (`.ice` files) into language-specific stubs and skeletons.

### Common Slice Compilers
The compiler name follows the pattern `slice2<language>`. Common examples include:
- `slice2cpp`: Generates C++ code.
- `slice2py`: Generates Python code.
- `slice2java`: Generates Java code.
- `slice2cs`: Generates C# code.
- `slice2js`: Generates JavaScript code.

### Basic Usage Pattern
1. **Define the Interface:** Create a file (e.g., `Printer.ice`).
   ```ice
   interface Printer {
       void printString(string s);
   }
   ```
2. **Compile the Contract:**
   ```bash
   slice2cpp Printer.ice
   ```
3. **Implement and Connect:** Use the generated classes to implement the server logic or call the remote object from a client.

## Component Management
Ice includes several specialized services for enterprise-grade distributed systems:

- **IceGrid:** Use for server deployment, replication, and monitoring. It acts as a location service, allowing clients to find servers by identity rather than hardcoded endpoints.
- **IceStorm:** A messaging service for publish-subscribe architectures. Use this when you need decoupled one-to-many communication.
- **Glacier2:** An application-level gateway. Use this to allow Ice clients to communicate securely with servers behind firewalls.
- **IceMX:** Provides instrumentation and metrics for monitoring the performance of Ice applications.

## Expert Tips and Best Practices
- **Version Matching:** Always ensure the branch of the `ice-demos` repository matches the version of the Ice runtime you are using (e.g., use the `3.7` branch if running Ice 3.7.1).
- **Endpoint Configuration:** While endpoints can be hardcoded (e.g., `greeter:tcp -h localhost -p 4061`), use **IceGrid** for production environments to enable dynamic discovery and failover.
- **Language Interoperability:** Leverage the fact that Ice is language-agnostic. A Python client can communicate with a C++ server without any additional configuration, provided they share the same Slice definition.
- **Transport Selection:** Choose the appropriate transport for your use case:
  - `tcp` or `ssl` for reliable stream-oriented communication.
  - `udp` for unreliable datagrams.
  - `ws` or `wss` for web-based clients.

## Reference documentation
- [The Ice framework](./references/github_com_zeroc-ice_ice.md)
- [zeroc-ice - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_zeroc-ice_overview.md)
- [Homebrew Ice Nightly Tap](./references/github_com_zeroc-ice_homebrew-nightly.md)
- [Sample programs for Ice](./references/github_com_zeroc-ice_ice-demos.md)