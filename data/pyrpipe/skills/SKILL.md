---
name: pyrpipe
description: pyrpipe is a Python framework that wraps Unix commands into an object-oriented API to create and automate bioinformatics pipelines. Use when user asks to build RNA-Seq pipelines, wrap Unix commands in Python, download SRA data, trim adapters, or align reads.
homepage: https://github.com/urmi-21/pyrpipe
metadata:
  docker_image: "quay.io/biocontainers/pyrpipe:0.0.5--py_0"
---

# pyrpipe

## Overview
pyrpipe is a lightweight Python framework that enables the creation of robust bioinformatics pipelines by wrapping Unix commands into an object-oriented Python API. It is particularly effective for RNA-Seq processing, providing built-in mechanisms for logging, command verification, and pipeline resumption. Use this skill to automate the transition from raw sequencing data to quantified expression levels while ensuring every step is documented and verifiable.

## Core Usage Patterns

### Importing Unix Tools
To use any Unix command within a Python script, use the `Runnable` class. This allows you to treat command-line tools as Python objects.

```python
from pyrpipe.runnable import Runnable
# Initialize the tool
grep = Runnable(command='grep')
# Execute with arguments
grep.run('search_term', 'input_file.txt', verbose=True)
```

### Standard RNA-Seq Workflow
pyrpipe provides high-level modules for common bioinformatics tools. A typical pipeline involves downloading data, trimming adapters, and aligning reads.

```python
from pyrpipe.sra import SRA
from pyrpipe.qc import Trimgalore
from pyrpipe.mapping import Star

# Initialize tools with resource parameters
tg = Trimgalore(threads=8)
st = Star(index='path/to/index', threads=4)

# Chain operations for a specific SRA accession
srr_id = 'SRR976159'
SRA(srr_id).trim(tg).align(st)
```

### Diagnostic and Environment Setup
Before running complex pipelines, verify that the environment and third-party dependencies (like SRA-Tools) are correctly configured.

- Run `pyrpipe_diagnostic test` from the terminal to check the status of SRA-Tools and other dependencies.
- If SRA downloads fail, use `vdb-config -i` to ensure the public user-repository is correctly set.

## Best Practices and Expert Tips

- **Dry Runs**: Always perform a dry run to check dependencies and command syntax without executing the actual processing. This saves time and prevents mid-pipeline failures.
- **Integrity Verification**: pyrpipe automatically verifies the integrity of output targets. Ensure your scripts check the return status of `.run()` or chained methods to handle missing or corrupted outputs.
- **Resource Management**: Explicitly define `threads` and `memory` parameters when initializing tool objects (e.g., `Star(threads=12)`) to prevent over-subscription of HPC resources.
- **Logging**: pyrpipe generates comprehensive logs. In case of failure, check the logs for the exact command string that was executed and its return status.
- **Resume Feature**: If a pipeline is interrupted, pyrpipe can skip steps that have already produced valid output files, allowing for efficient restarts.

## Reference documentation
- [pyrpipe GitHub Repository](./references/github_com_urmi-21_pyrpipe.md)
- [pyrpipe Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pyrpipe_overview.md)