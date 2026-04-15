---
name: scythe
description: Scythe tracks the execution of specific code paths in production to help developers identify and prune legacy or dead code. Use when user asks to instrument code with probes, gather probe definitions from source directories, analyze the time since a probe was last triggered, or delete tracked probes.
homepage: https://github.com/michaelfeathers/scythe
metadata:
  docker_image: "biocontainers/scythe:v0.994-4-deb_cv1"
---

# scythe

---

## Overview
Scythe is a lightweight diagnostic tool designed to help developers prune legacy codebases by tracking actual execution in production. Unlike static analysis, Scythe uses runtime "probes"—simple function calls placed in suspicious code paths—to record the last time a specific block of code was executed. This allows teams to distinguish between truly dead code and code that is simply rarely used, reducing the risk of deleting critical but infrequent logic.

## Environment Setup
Before using the CLI, ensure the environment is configured to store probe data:

1.  **Set the Probe Directory**: Define where Scythe will store its history files.
    ```bash
    export SCYTHE_PROBE_DIR=/path/to/probe/data
    ```
2.  **Update PATH**: Add the Scythe library to your system path.
    ```bash
    export PATH=$PATH:/path/to/scythe/lib
    ```

## Instrumenting Code
Place probes in the code paths you wish to monitor. Scythe supports Ruby, Python 3.x, Java, and Node.js.

### Probe Syntax
For maximum compatibility across languages, Scythe recognizes two specific forms:
*   `scythe_probe("probe_name")`
*   `scythe_probe "probe_name"`

### Constraints
*   **Naming**: Use only alphanumerics and underscores (e.g., `cleanup_legacy_auth_v1`).
*   **Quotes**: You must use **double quotes**. Single quotes are not supported by the gatherer.
*   **Uniqueness**: Ensure every probe name is unique across the entire codebase.

## CLI Usage Patterns

### 1. Gathering Probes
Before Scythe can report on probes, it must "discover" them in your source code. Run this command recursively on your source directory:
```bash
scythe -g <source_directory>
```
**Best Practice**: Run `scythe -g .` as part of your CI/CD build process to ensure the probe registry is always up to date with the latest deployments.

### 2. Analyzing Usage
To see how long it has been since each probe was triggered, use the status option:
```bash
# Report in days (default)
scythe -s

# Report in hours or seconds for higher precision
scythe -s hours
scythe -s secs
```

### 3. Deleting Probes
Once you have decided to delete the instrumented code, remove the probe from Scythe's internal tracking:
```bash
scythe -d <probe_name>
```

## Expert Tips
*   **Naming Conventions**: Use a structured naming convention like `module_feature_function` to make the status reports easier to read without cross-referencing the source code.
*   **Verification**: After deploying a new probe, run `scythe -s secs` and trigger the code path manually to verify that the probe is correctly recording hits in the `SCYTHE_PROBE_DIR`.
*   **Phased Deletion**: If a probe hasn't been called in 30–90 days (depending on your business cycle), it is a strong candidate for deletion. Always check for seasonal tasks (e.g., "end_of_year_report") before removing code that appears dead.

## Reference documentation
- [Scythe Main README](./references/github_com_michaelfeathers_scythe.md)
- [Probe Implementations](./references/github_com_michaelfeathers_scythe_tree_master_probes.md)