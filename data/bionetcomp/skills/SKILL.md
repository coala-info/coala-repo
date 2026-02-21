---
name: bionetcomp
description: BioNetComp is a specialized tool for differential network analysis.
homepage: https://github.com/lmigueel/bionetcomp/
---

# bionetcomp

## Overview
BioNetComp is a specialized tool for differential network analysis. It automates the retrieval of protein-protein interaction data from the STRING database based on two input gene lists. The skill enables the identification of conserved "core" network components versus condition-specific or species-specific "exclusive" components. It is particularly useful for comparing transcriptomic or proteomic profiles across different experimental conditions, developmental stages, or closely related organisms.

## Command-Line Usage
The primary interface is the `bionetcomp` command. It requires two input files, a taxonomy ID, and an output directory.

### Basic Syntax
```bash
bionetcomp --in1 list1.txt --in2 list2.txt --taxid <TAXONOMY_ID> --output_folder <FOLDER_NAME>
```

### Key Arguments
- `--in1`, `--in2`: Plain text files containing one gene/protein identifier per line.
- `--taxid`: The NCBI taxonomy ID (e.g., `9606` for Human, `4932` for S. cerevisiae).
- `--threshold`: (Optional) STRING interaction score (0 to 1). Higher values increase confidence but reduce network size.
- `--fdr`: (Optional) False Discovery Rate cutoff for the enrichment analysis (default is often 0.05).

### Example: Comparing Human Gene Sets
```bash
bionetcomp --in1 cancer_genes.txt --in2 healthy_genes.txt --taxid 9606 --output_folder comparative_analysis --threshold 0.7
```

## Expert Tips and Best Practices
- **Identifier Consistency**: Ensure both input files use the same identifier type (e.g., Gene Symbols or UniProt IDs) supported by the STRING API for that specific taxonomy ID.
- **Output Interpretation**:
    - **node_report.txt / edge_report.txt**: Use these for downstream custom scripting or importing into Cytoscape.
    - **jaccard_coefficient_nodes_and_edges.png**: Check this first to quantify the overall similarity between the two networks.
    - **Centrality Rankings**: Focus on genes with high betweenness centrality in the `Betweeness_Centrality_values_networkX.txt` files; these often represent critical bottlenecks or signaling hubs unique to one condition.
- **Visualizing Hubs**: In the generated plots, node size is proportional to the degree (number of connections). Look for large nodes in the `only_networkX_edges.png` files to find condition-specific hubs.
- **Enrichment Analysis**: The tool automatically generates enrichment for exclusive nodes (`enrichr_networkX_exclusive_nodes_enrichment.txt`). This is often more biologically informative than the whole-network enrichment as it highlights the functional shift between the two lists.

## Python API Integration
For more complex workflows, use the Python library directly:

```python
import bionetcomp
import os

# Setup
out = "results"
os.makedirs(out, exist_ok=True)

# 1. Build networks from STRING
net1 = bionetcomp.network_development("list1.txt", 9606, 0.4)
net2 = bionetcomp.network_development("list2.txt", 9606, 0.4)

# 2. Generate metrics and comparison
g1, g2 = bionetcomp.comparative_metrics(net1, net2, out)
bionetcomp.compare_networks(net1, net2, g1, g2, out, 0.05, 9606)
```

## Reference documentation
- [BioNetComp GitHub Repository](./references/github_com_lmigueel_BioNetComp.md)
- [BioNetComp Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bionetcomp_overview.md)