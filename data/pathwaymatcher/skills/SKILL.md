---
name: pathwaymatcher
description: PathwayMatcher maps biological identifiers such as genes, proteins, proteoforms, and genetic variants to the Reactome pathway database. Use when user asks to map omics data to pathways, perform pathway enrichment analysis, identify reactions involving specific proteoforms, or analyze the functional impact of genetic variants.
homepage: https://github.com/LuisFranciscoHS/PathwayMatcher
---


# pathwaymatcher

## Overview
PathwayMatcher is a specialized bioinformatics tool designed to bridge the gap between raw omics data and systems biology. It allows researchers to systematically map various biological identifiers to the Reactome pathway knowledgebase. Unlike general mappers, it supports high-resolution mapping for proteoforms (proteins with specific post-translational modifications) and genetic variants (SNPs). Use this skill when you need to perform pathway enrichment analysis, identify reactions involving specific protein states, or generate biological networks from experimental datasets.

## Input Types and Formatting
PathwayMatcher requires specific input formats based on the data type. Use the `-t` flag to specify the type.

| Data Type | Flag | Format Description |
| :--- | :--- | :--- |
| **Genes** | `-t gene` | One HUGO gene symbol per line (e.g., `CFTR`). |
| **UniProt** | `-t uniprot` | One UniProt accession per line (e.g., `P00519`). |
| **Ensembl** | `-t ensembl` | One Ensembl gene or protein ID per line. |
| **Proteoforms** | `-t proteoform` | `Accession;MOD:ID:Site` (e.g., `P16220;00046:133`). |
| **RSID** | `-t rsid` | One dbSNP identifier per line (e.g., `rs187174427`). |
| **Chr/BP** | `-t chrbp` | Space-separated chromosome and base pair (e.g., `1 210827406`). |
| **VCF** | `-t vcf` | Standard VCF v4.3 file (first 4 columns mandatory). |

## Common CLI Patterns

### Basic Pathway Mapping
To map a list of proteins to Reactome pathways:
```bash
java -jar PathwayMatcher.jar -i input_proteins.txt -t uniprot -o ./output_results/
```

### Proteoform Matching with PTMs
When working with post-translational modifications, ensure the PSI-MOD 5-digit identifiers are used. PathwayMatcher will match only the reactions where the protein exists in that specific state.
```bash
java -jar PathwayMatcher.jar -i proteoforms.txt -t proteoform
```

### Genetic Variant Analysis
For SNPs, PathwayMatcher maps variants to the proteins they affect and subsequently to pathways. Note that input lists for `rsid` and `chrbp` should be sorted by chromosome and base pair for optimal performance.
```bash
java -jar PathwayMatcher.jar -i variants.vcf -t vcf
```

## Expert Tips
- **Java Version**: Ensure Java 1.8 (64-bit) is installed.
- **Memory Management**: For large VCF files or proteoform datasets, increase the JVM heap size using `-Xmx` (e.g., `java -Xmx4g -jar PathwayMatcher.jar ...`).
- **Output Files**: PathwayMatcher typically produces three outputs:
    1. `search.tsv`: Mapping of input entities to reactions and pathways.
    2. `analysis.tsv`: Statistical overrepresentation analysis (p-values).
    3. `network.txt`: Biological network files for visualization.
- **Proteoform Flexibility**: If the specific PTM type is unknown but the site is known, use the modification ID `00000` (e.g., `P62753;00000:245`).



## Subcommands

| Command | Description |
|---------|-------------|
| match-chrbp | Match a list of genetic variants as chromosome and base pairs |
| match-ensembl | Match a list of Ensembl protein identifiers |
| match-genes | Match a list of gene names and perform over-representation analysis |
| match-modified-peptides | Match a list of peptides with post translational modifications |
| match-peptides | Match a list of peptides to proteins and identify associated reactions and pathways. |
| match-proteoforms | Match a list of proteoforms to reactions and pathways |
| match-rsids | Match a list of genetic variants as RsIds |
| match-uniprot | Match a list of UniProt protein accessions to reactions and pathways, and perform over-representation analysis. |
| match-vcf | Match a list of genetic variants in VCF format |

## Reference documentation
- [Input Formatting Guide](./references/github_com_PathwayAnalysisPlatform_PathwayMatcher_Dev_wiki_Input.md)
- [Installation and Setup](./references/github_com_PathwayAnalysisPlatform_PathwayMatcher_Dev_wiki_Installation.md)
- [Examples and Use Cases](./references/github_com_PathwayAnalysisPlatform_PathwayMatcher_Dev_wiki_Examples.md)