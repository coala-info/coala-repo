---
name: argnorm
description: argnorm is a specialized bioinformatic tool designed to solve the "vocabulary problem" in antibiotic resistance gene (ARG) annotation.
homepage: https://github.com/BigDataBiology/argNorm
---

# argnorm

## Overview
argnorm is a specialized bioinformatic tool designed to solve the "vocabulary problem" in antibiotic resistance gene (ARG) annotation. Different tools and databases (e.g., CARD, Megares, ARG-ANNOT) often use inconsistent naming conventions for the same genes. argnorm maps these diverse identifiers to a standardized ARO accession number. Beyond simple normalization, it provides functional enrichment by adding drug categorization, identifying the specific antibiotic classes a gene confers resistance to, and grouping them into broader categories (e.g., mapping a specific gene to "amoxicillin" and then to the broader "beta-lactam" class).

## Installation
Install via conda or pip:
```bash
conda install bioconda::argnorm
# OR
pip install argnorm
```

## CLI Usage Patterns

### Basic Normalization
The core command requires specifying the tool used for the original annotation, the input file, and the output path.

```bash
argnorm [tool] -i input_annotation.tsv -o normalized_output.tsv
```

### Supported Tools and Database Selection
For many tools, you must specify the database used during the initial annotation via the `--db` flag to ensure correct mapping.

| Tool | Required/Optional `--db` | Supported DB Values |
| :--- | :--- | :--- |
| `abricate` | Required | `ncbi`, `resfinder`, `argannot`, `megares`, `card` |
| `deeparg` | Optional | `deeparg` |
| `resfinder` | Optional | `resfinder` |
| `amrfinderplus`| Optional | `ncbi` |
| `groot` | Required | `groot-db`, `groot-core-db`, `groot-argannot`, `groot-card`, `groot-resfinder` |
| `argsoap` | Optional | `sarg` |
| `hamronization`| Optional | N/A (Processes hAMRonized outputs) |

### Handling hAMRonization Outputs
If you have already used the `hAMRonization` tool to unify file formats, use the `hamronization` subcommand. Note that argnorm only supports hAMRonized results that originated from its supported tool list.

```bash
argnorm hamronization -i hamronized_results.tsv -o normalized_output.tsv
```

To skip unsupported tools within a large hAMRonized file:
```bash
argnorm hamronization -i input.tsv -o output.tsv --hamronization_skip_unsupported_tool
```

## Expert Tips and Best Practices
- **Check Versions**: argnorm is version-sensitive regarding the underlying databases. If mapping rates are low, verify that your annotation tool version matches those supported by argnorm (e.g., ResFinder v4.0, DeepARG v2).
- **Output Columns**: The normalized file will include new columns: `ARO`, `ARO_name`, `confers_resistance_to_names`, and `resistance_to_drug_classes_names`. Use these for downstream statistical analysis and visualization.
- **Memory Efficiency**: The tool is highly optimized, requiring only ~200MiB of RAM, making it suitable for execution on standard laptops even with thousands of input genes.
- **Library Usage**: For Python-based workflows, you can use `argnorm.lib.map_to_aro` to map individual gene names to ARO terms programmatically.

## Reference documentation
- [argNorm GitHub Repository](./references/github_com_BigDataBiology_argNorm.md)
- [argNorm Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_argnorm_overview.md)
- [argNorm Tags and Versions](./references/github_com_BigDataBiology_argNorm_tags.md)