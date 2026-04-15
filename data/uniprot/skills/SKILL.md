---
name: uniprot
description: The uniprot skill processes protein accession numbers to retrieve comprehensive functional data from UniProt. Use when user asks to retrieve protein metadata, get taxonomic information, perform Gene Ontology analysis, identify biological pathways, analyze protein-protein interactions, map diseases, download protein sequences, or visualize protein data.
homepage: https://github.com/Proteomicslab57357/UniprotR
metadata:
  docker_image: "quay.io/biocontainers/uniprot:1.3--py27_0"
---

# uniprot

## Overview

The `uniprot` skill provides a specialized workflow for interacting with the Universal Protein Resource (UniProt) through the UniprotR R package. It transforms raw protein accession numbers into comprehensive functional datasets. Use this skill to automate the retrieval of biological metadata, perform enrichment analysis, and generate complex visualizations like gene networks, chromosome localizations, and GO term distributions. It is particularly effective for proteomics researchers who need to bridge the gap between raw identification lists and downstream biological interpretation.

## Usage Instructions

### Data Input and Taxonomy
The foundation of most workflows is a list of UniProt accession numbers.
- **Loading Accessions**: Use `GetAccessionList("path/to/file.csv")`. Ensure the accession numbers are located in the first column of the CSV.
- **Taxonomy Retrieval**: Use `GetNamesTaxa(Accessions)` to fetch naming and taxonomic information.
- **Genomic Visualization**: Use `PlotChromosomeInfo(TaxaObj)` to visualize the chromosomal localization of your protein list.

### Gene Ontology (GO) Analysis
Retrieve and visualize the functional roles of proteins across Biological Process, Molecular Function, and Subcellular Localization.
- **Data Retrieval**: `GeneOntologyObj <- GetProteinGOInfo(Accessions)`
- **Specific Plots**:
  - Biological Process: `PlotGOBiological(GeneOntologyObj, Top = 10)`
  - Molecular Function: `Plot.GOMolecular(GeneOntologyObj, Top = 20)`
  - Subcellular Localization: `Plot.GOSubCellular(GeneOntologyObj)`
- **Publication Export**: Use `PlotGOAll(GOObj = GeneOntologyObj, Top = 10, directorypath = getwd())` to save high-quality combined plots to your working directory.

### Pathway Enrichment and Interaction
Identify overrepresented biological pathways and protein-protein interactions.
- **Enrichment**: Use `Pathway.Enr(Accessions)` for KEGG and Reactome analysis.
- **Visualizing Pathways**: `PlotEnrichedPathways(Accs = Accessions, Path = "output_path", theme = "jama")`. Supported themes include "jama" and "lancet".
- **STRING Integration**: Generate interaction networks within your input data using `GetproteinNetwork(Accessions, "output_path/Network.pdf")`.

### Pathology and Sequences
- **Disease Mapping**: Use `GetPathology_Biotech(Accessions)` followed by `Get.diseases()` to identify clinical associations.
- **FASTA Retrieval**: Use `GETSeqFastaUniprot(Accessions, FileName = "output")` to download sequences for MS/MS database searching or alignment.

## Expert Tips
- **Network Analysis**: When using `PlotGenesNetwork`, ensure you have first run `GetNamesTaxa` as the network plot relies on the gene names retrieved in the taxonomy object.
- **Batch Processing**: For large protein lists, prefer functions that save directly to disk (like `PlotGOAll` or `GETSeqFastaUniprot`) to avoid memory overhead in the R environment.
- **Visualization Themes**: Use the `theme` parameter in enrichment plots to match the aesthetic requirements of specific journals (e.g., `theme = "lancet"`).

## Reference documentation
- [UniprotR Main Documentation](./references/github_com_Proteomicslab57357_UniprotR.md)