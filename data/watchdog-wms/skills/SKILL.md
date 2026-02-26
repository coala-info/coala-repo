---
name: watchdog-wms
description: Watchdog-wms is a Java-based Workflow Management System designed for high-throughput data analysis. Use when user asks to process replicate data, resume a workflow, detach from or reattach to a workflow session, manage dependencies, implement custom scripts, generate module definitions or documentation, enable module versioning, configure error detection, execute workflows across distributed systems, or extend WMS functionality.
homepage: https://www.bio.ifi.lmu.de/watchdog https://github.com/klugem/watchdog
---


# watchdog-wms

## Overview
Watchdog is a Java-based Workflow Management System (WMS) designed specifically for high-throughput data analysis, such as next-generation sequencing. It excels at handling complex dependencies across numerous samples and replicates. This skill provides the procedural knowledge required to navigate Watchdog's ecosystem, including its GUI-based construction, CLI execution modes, and integration with package managers like Conda and containerization via Docker.

## Core Capabilities and Workflow
Watchdog 2.0 introduces several critical execution modes and management features that should be prioritized during workflow design:

- **Replicate Processing**: Use the native support for replicate data to avoid manual iteration in script definitions.
- **Execution Control**:
    - **Resume Mode**: Execute only altered or unfinished tasks to save computational resources.
    - **Detach/Reattach**: Start a workflow execution, disconnect from the session, and reattach later to monitor progress.
- **Environment Management**: Leverage the XML plugin system to manage dependencies via Conda or Docker containers, ensuring reproducibility across different computing environments.
- **Custom Hooks**: Implement "before" and "after" command scripts to handle data preparation or cleanup tasks outside the core module logic.

## Best Practices for Module and Workflow Creation
- **Module Definition**: Use the provided helper scripts to generate new module definitions. This ensures compatibility with the Watchdog GUI and reporting systems.
- **Documentation**: Always use the standard documentation format for modules. Use the documentation template generator to maintain consistency, which allows for the automatic generation of a module reference book.
- **Versioning**: Enable module versioning and third-party software version retrieval to ensure that reports accurately reflect the tools used during execution.
- **Error Detection**: Configure customizable error detection settings to allow for manual intervention or automated halts when specific failure conditions are met.

## Distributed and Remote Execution
- **Distributed Systems**: Watchdog supports execution across distributed computer systems. Ensure that paths are accessible across the network or utilize the remote storage support features.
- **Plugin System**: If the core functionality is insufficient, use the flexible plugin system to extend the WMS without modifying the original Java source code.

## Reference documentation
- [Watchdog Software Overview](./references/www_bio_ifi_lmu_de_software_watchdog.md)
- [Bioconda Watchdog-WMS Package Details](./references/anaconda_org_channels_bioconda_packages_watchdog-wms_overview.md)