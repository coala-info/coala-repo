---
name: antismash-lite
description: This tool identifies and characterizes biosynthetic gene clusters in genomic sequences to map secondary metabolism. Use when user asks to run antiSMASH, identify biosynthetic gene clusters, configure detection strictness, develop custom detection rules, or create new analysis modules.
homepage: https://docs.antismash.secondarymetabolites.org/intro/
metadata:
  docker_image: "quay.io/biocontainers/antismash-lite:8.0.1--pyhdfd78af_0"
---

# antismash-lite

## Overview

This skill provides procedural knowledge for operating antiSMASH, the gold-standard software for the automated identification and characterization of biosynthetic gene clusters (BGCs). It transforms genomic sequences into annotated maps of secondary metabolism by identifying core biosynthetic enzymes (via HMM profiles) and their genomic neighborhoods. Use this skill to navigate the local installation, configure detection strictness, and extend the tool's capabilities through custom rules and modules.

## Core Workflows

### Running antiSMASH-lite
The "lite" version typically refers to the core engine without the heavy pre-computed databases. 
- **Input**: Supports GenBank, FASTA, or EMBL formats.
- **Basic Execution**: `antismash input_file.gbk`
- **Strictness Levels**: Use `--hmmdetection-strictness [strict, relaxed, loose]` to control the sensitivity of cluster detection. "Loose" includes rules defined in `loose.txt` for broader discovery.

### Developing Detection Rules
Rules define the logic for identifying "protoclusters" based on co-located genes.
1. **Rule Structure**: Defined in a domain-specific language. Key fields include:
   - `CONDITIONS`: The core logic (e.g., `cds(PKS_AT and not ANY_KS)`).
   - `CUTOFF`: Max range (kb) to search for satisfying conditions.
   - `NEIGHBOURHOOD`: Genomic context range for surrounding genes.
2. **HMM Integration**: New profiles must be added to `hmmdetails.txt` in the format: `<name> <description> <cutoff> <filename>`.
3. **Dynamic Profiles**: For complex patterns, implement a Python class subclassing `DynamicProfile`.

### Creating Analysis Modules
To add new types of sequence analysis, create a directory in `antismash/modules/` with an `__init__.py` containing:
- `get_arguments()`: Define CLI options using `ModuleArgs`.
- `check_options()`: Validate user input.
- `run_on_record()`: Execute the primary analysis logic.
- `ModuleResults` subclass: Handle JSON serialization and record annotation.

## Expert Tips & Best Practices

- **Avoid Redundancy**: When writing modules, do not duplicate functions from `antismash.common`. Use `common.subprocessing` for external calls and `common.secmet` for record manipulation.
- **Data Integrity**: Never modify the `Record` object directly during analysis; store data in a `ModuleResults` object and use the `add_to_record()` method only after all analysis modules have finished.
- **Performance**: Avoid reloading static data or using strings as data structures. Use type hints (`mypy`) to ensure code reliability.
- **Testing**: 
  - Use `test_` prefix for unit tests (no external binaries).
  - Use `integration_` prefix for tests involving external commands.
  - Run `pytest` from the module's `test/` subdirectory.



## Subcommands

| Command | Description |
|---------|-------------|
| antismash | antiSMASH 8.0.1 |
| download-antismash-databases | Base directory for the antiSMASH databases |

## Reference documentation

- [Core Data Structures](./references/github_com_antismash_antismash_wiki_Core-Data-Structures.md)
- [Creating detection rules](./references/github_com_antismash_antismash_wiki_Creating-detection-rules.md)
- [Analysis module template](./references/github_com_antismash_antismash_wiki_Analysis-module-template.md)