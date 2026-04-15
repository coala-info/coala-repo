---
name: argnorm
description: argNorm normalizes antibiotic resistance gene naming inconsistencies by mapping tool-specific identifiers to the Antibiotic Resistance Ontology. Use when user asks to normalize ARG database outputs, map gene identifiers to ARO terms, or standardize resistance annotations from tools like Abricate, ResFinder, and AMRFinderPlus.
homepage: https://github.com/BigDataBiology/argNorm
metadata:
  docker_image: "quay.io/biocontainers/argnorm:1.1.0--pyhdfd78af_0"
---

# argnorm

## Overview

argNorm is a normalization tool designed to resolve the naming inconsistencies found across different antibiotic resistance gene (ARG) databases. By mapping tool-specific gene identifiers to the Antibiotic Resistance Ontology (ARO) maintained by the CARD database, argNorm provides a "common language" for resistance annotations. Beyond simple mapping, it enhances datasets by appending functional metadata, including the specific drugs and broader drug classes to which a gene confers resistance. This allows researchers to compare results from different pipelines (e.g., comparing ResFinder results with AMRFinderPlus results) on a standardized scale.

## CLI Usage Patterns

The general syntax for argNorm follows a tool-specific subcommand structure:

```bash
argnorm [tool] -i <input_file> -o <output_file>
```

### Supported Tool Subcommands
- `amrfinderplus`: For NCBI AMRFinderPlus outputs (v3.10 and v4.0 supported).
- `resfinder`: For ResFinder outputs.
- `deeparg`: For DeepARG outputs.
- `groot`: For GROOT outputs.
- `abricate`: For Abricate outputs (requires specifying the database used).
- `sarg`: For SARG (Structured Antibiotic Resistance Genes) database outputs.
- `hamronization`: For outputs already processed by the hAMRonization tool.

### Common CLI Examples

**Normalizing Abricate results:**
When using Abricate, you must specify the database that was used during the initial annotation:
```bash
argnorm abricate --db resfinder -i results.tsv -o normalized_results.tsv
```

**Normalizing GROOT results:**
```bash
argnorm groot --db groot-card -i groot_output.tsv -o normalized_groot.tsv
```

**Processing hAMRonization outputs:**
hAMRonization often combines results from multiple tools. If the input contains tools not supported by argNorm, use the skip flag to prevent errors:
```bash
argnorm hamronization -i hamronized_report.tsv -o normalized_report.tsv --hamronization_skip_unsupported_tool
```

## Expert Tips and Best Practices

### Handling Output Headers
When argNorm generates a TSV via the CLI, it prepends a comment line indicating the version (e.g., `# argNorm version: 1.1.0`). 
**Critical for Downstream Analysis:** If you are loading these files into Python/Pandas, you must skip this header line:
```python
import pandas as pd
df = pd.read_csv('argnorm_output.tsv', sep='\t', skiprows=1)
```

### Drug Categorization Logic
argNorm maps genes to the immediate child of the 'antibiotic molecule' node in the ARO. For example, if a gene confers resistance to Tobramycin, argNorm will categorize the drug class as "aminoglycoside antibiotic." It utilizes `regulates`, `part_of`, and `participates_in` relationships to ensure efflux pumps and complex proteins are correctly mapped to resistance profiles even when direct `is_a` relationships are missing.

### ARO Versioning
As of version 0.7.0, argNorm supports ARO v4.0.0. Be aware that ARO mappings can change significantly between ontology versions. If you are re-analyzing old data, ensure you are using the latest version of argNorm to benefit from the 1200+ beta-lactamase genes added in recent ARO updates.

### Cut-Off Scores
argNorm includes a `Cut_Off` column in its output. These scores (`Perfect`, `Strict`, `Loose`) are derived from RGI's discovery paradigm. If a mapping was performed via manual curation rather than RGI, the score will be labeled as `Manual`.



## Subcommands

| Command | Description |
|---------|-------------|
| argnorm | argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology). |
| argnorm | argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology). |
| argnorm | argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology). |
| argnorm | argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology). |
| argnorm | argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology). |
| argnorm | argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology). |
| argnorm argsoap | argNorm normalizes ARG annotation results from different tools and databases to the same ontology, namely ARO (Antibiotic Resistance Ontology). |

## Reference documentation
- [argNorm README](./references/github_com_BigDataBiology_argNorm_blob_main_README.md)
- [argNorm Changelog](./references/github_com_BigDataBiology_argNorm_blob_main_CHANGELOG.md)