---
name: selenzy_wrapper
description: This tool wraps the Selenzy enzyme selection engine to identify and rank enzyme sequences for metabolic pathways in rpSBML format. Use when user asks to select enzymes for a pathway, rank enzyme sequences based on taxonomic distance, or annotate SBML files with catalytic relevance scores.
homepage: https://github.com/brsynth/selenzy-wrapper
---


# selenzy_wrapper

## Overview
The `selenzy_wrapper` is a specialized Python tool that wraps the Selenzy enzyme selection engine to work seamlessly with the rpSBML format. It is primarily used in synthetic biology workflows to identify the most promising enzyme sequences for a predicted metabolic pathway. By analyzing the reactions within an SBML file, it ranks potential enzymes based on their catalytic relevance and the taxonomic proximity of their native organisms to the intended production host.

## Installation
The tool is best installed via Conda to manage its bio-specific dependencies:
```bash
conda install -c brsynth -c conda-forge -c bioconda selenzy_wrapper
```

## Command Line Usage
The wrapper can be executed as a Python module. The primary workflow involves taking an input pathway file and generating an annotated output file containing the ranked enzyme information.

### Basic Execution
To process a pathway and save the results to a new SBML file:
```bash
python -m selenzy_wrapper <input_pathway.xml> <output_results.xml>
```

### Advanced Options
Based on recent updates to the tool, you can specify custom data paths for the underlying Selenzy databases:
```bash
python -m selenzy_wrapper <input.xml> <output.xml> --data-path /path/to/selenzy/data
```

## Python API Integration
For programmatic use within a larger bioinformatics pipeline, use the `selenzy_pathway` function. This requires the `rpSBML` object structure.

```python
from selenzy_wrapper import selenzy_pathway

# Load the pathway using the rpSBML framework
# Note: This assumes rpSBML/rpTools is available in the environment
pathway = rpPathway.from_rpSBML(infile='pathway.xml')

# Run the ranking algorithm
selenzy_pathway(pathway=pathway)

# Export the annotated pathway
pathway.to_rpSBML().write_to_file('selenzy_annotated.xml')
```

## Expert Tips and Best Practices
- **Taxonomic IDs**: Ensure your input SBML contains valid taxonomic information for the target host. The tool uses these IDs to calculate the taxonomic distance, which is a critical component of the final score.
- **UniProt Mapping**: The wrapper supports exporting UniProt IDs to CSV. This is useful if you need to perform downstream sequence analysis or batch-download protein sequences.
- **Environment Consistency**: Since this tool is a wrapper for `rptools` components, ensure that your environment has `rptools` correctly pinned (version 5.x or higher is typically recommended) to avoid schema mismatches in the SBML tags.
- **Data Path Management**: If running in a containerized or HPC environment, always use the `--data-path` argument to point to the local mirror of the Selenzy database to avoid unnecessary network overhead or "file not found" errors.

## Reference documentation
- [Anaconda Bioconda selenzy_wrapper Overview](./references/anaconda_org_channels_bioconda_packages_selenzy_wrapper_overview.md)
- [GitHub brsynth/selenzy-wrapper README](./references/github_com_brsynth_selenzy-wrapper.md)
- [GitHub brsynth/selenzy-wrapper Commits](./references/github_com_brsynth_selenzy-wrapper_commits_master.md)