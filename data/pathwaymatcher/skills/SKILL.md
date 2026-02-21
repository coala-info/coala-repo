---
name: pathwaymatcher
description: PathwayMatcher is a Java-based command-line tool designed to bridge the gap between raw omics data and functional biological pathways.
homepage: https://github.com/LuisFranciscoHS/PathwayMatcher
---

# pathwaymatcher

## Overview
PathwayMatcher is a Java-based command-line tool designed to bridge the gap between raw omics data and functional biological pathways. Unlike many tools that only map at the gene level, PathwayMatcher supports high-resolution mapping for proteoforms, allowing you to specify exact phosphorylation sites or other PTMs to see which specific reactions are affected. It is the primary tool for systematic, unbiased matching of human biomedical data to the Reactome database.

## Usage Guidelines

### Core Command Structure
PathwayMatcher is typically executed as a JAR file. The basic syntax is:
```bash
java -jar PathwayMatcher.jar -i <input_file> -t <input_type> [options]
```

### Supported Input Types (`-t`)
Specify the input type using the `-t` flag. Common types include:
- `uniprot`: List of UniProt IDs.
- `genes`: List of Gene names.
- `ensembl`: Ensembl identifiers.
- `peptides`: Amino acid sequences.
- `proteoforms`: UniProt IDs with PTM coordinates (e.g., `P01234;00047:45`).
- `variants`: Genetic variants (requires VCF-like format).

### Common CLI Patterns
- **Standard Protein Mapping**:
  `java -jar PathwayMatcher.jar -i proteins.txt -t uniprot -o ./output/`
- **Proteoform Mapping (High Precision)**:
  Use this when you have PTM data to filter for pathways where the protein exists in a specific modified state.
  `java -jar PathwayMatcher.jar -i proteoforms.txt -t proteoforms -mptm`
- **Generating Networks**:
  To output biological network files (GraphML/SIF) based on the matched entities:
  `java -jar PathwayMatcher.jar -i input.txt -t uniprot -gn`

### Key Options
- `-i, --input`: Path to the input file (one entry per line).
- `-o, --output`: Directory where results will be saved.
- `-t, --type`: The format of the input identifiers.
- `-mptm, --matchingPTM`: Enables strict matching for proteoforms based on PTMs.
- `-gu, --graphUniprot`: Generates a protein-protein interaction network.
- `-gp, --graphProteoform`: Generates a proteoform-specific interaction network.

### Output Files
PathwayMatcher generates three primary outputs in the specified output directory:
1. `search.tsv`: A mapping of input entities to reactions and pathways.
2. `analysis.tsv`: Statistical overrepresentation analysis (p-values, FDR) for the matched pathways.
3. `network.graphml/sif`: (Optional) Visualization-ready files for Cytoscape or other network tools.

## Best Practices
- **Java Version**: Ensure you are using Java 1.8, as newer versions may encounter compatibility issues with older releases of the tool.
- **Memory Allocation**: For large datasets (especially genetic variants), increase the JVM heap size: `java -Xmx4g -jar PathwayMatcher.jar ...`
- **Unbiased Analysis**: Remember that PathwayMatcher performs systematic matching without initial filtering. Always use the `analysis.tsv` file to determine which pathways are statistically significant for your specific biological context.

## Reference documentation
- [PathwayMatcher Wiki](./references/github_com_PathwayAnalysisPlatform_PathwayMatcher_Dev_wiki.md)
- [PathwayMatcher Overview](./references/github_com_PathwayAnalysisPlatform_PathwayMatcher_Dev.md)