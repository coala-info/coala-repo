---
name: bioconductor-spidermir
description: SpidermiR facilitates the retrieval, preparation, and integration of biological networks from GeneMania with miRNA-target interaction data. Use when user asks to query species-specific networks, integrate miRNA-gene interactions, or perform community detection and centrality analysis on biological networks.
homepage: https://bioconductor.org/packages/3.6/bioc/html/SpidermiR.html
---

# bioconductor-spidermir

name: bioconductor-spidermir
description: Expert assistance for using the SpidermiR R package to query, prepare, and download biological network data (GeneMania) and integrate it with miRNA-target interactions (mirWalk, miRTarBase, etc.). Use this skill when performing network analysis, integrating miRNA data with gene networks, or conducting community detection and centrality analysis in a bioinformatics context.

# bioconductor-spidermir

## Overview
SpidermiR is a Bioconductor package designed to facilitate the retrieval and integration of biological networks with miRNA data. It allows users to query GeneMania for specific network types (e.g., physical interactions, shared protein domains), download and prepare this data, and then overlay miRNA-gene interactions validated or predicted by multiple databases. It also provides wrappers for network analysis using `igraph` and visualization.

## Core Workflow

### 1. Query and Download Network Data
The process begins by identifying the species and the specific type of network desired.

```r
library(SpidermiR)

# 1. List available species and find the ID (e.g., Homo sapiens)
org <- SpidermiRquery_species("hsapiens")

# 2. List available network types for the organism
# Common types: "PHint" (Physical Interactions), "SHpd" (Shared Protein Domains), "COexp" (Co-expression)
net_list <- SpidermiRquery_spec_networks(organismID = org[6,])

# 3. Download the specific network
out_net <- SpidermiRdownload_net(net_list[1, ]) # Downloads the first network in the list

# 4. Prepare the network (converts IDs to Gene Symbols)
geneSymb_net <- SpidermiRprepare_NET(organismID = org[6,], data = out_net)
```

### 2. Integrate miRNA Data
Once a gene-gene network is established, you can integrate miRNA-target information based on specific diseases or validated targets.

```r
# Integrate miRNA-gene interactions for a specific disease
# miR_trg options: "val" (validated), "pred" (predicted)
miRNA_net <- SpidermiRanalyze_mirna_network(data = geneSymb_net, 
                                            disease = "prostate cancer", 
                                            miR_trg = "val")

# Create a complete network (miRNA-gene-gene)
miRNA_complNET <- SpidermiRanalyze_mirna_gene_complnet(data = geneSymb_net, 
                                                       disease = "prostate cancer", 
                                                       miR_trg = "val")
```

### 3. Network Analysis and Community Detection
SpidermiR provides tools to analyze the topology of the integrated networks.

```r
# Calculate degree centrality
centrality_results <- SpidermiRanalyze_degree_centrality(miRNA_net)

# Community detection (e.g., using Fast Greedy "FC" or Walktrap "WT")
comm <- SpidermiRanalyze_Community_detection(data = miRNA_net, type = "FC")

# Extract a specific community based on size or density
cd_net <- SpidermiRanalyze_Community_detection_net(data = miRNA_net, 
                                                   comm_det = comm, 
                                                   size = 5)
```

### 4. TCGA Integration
You can filter networks based on Differentially Expressed Genes (DEGs) from TCGA data.

```r
# Identify a sub-network based on TCGA expression matrix
# tumour and normal should be vectors of barcodes
sub_net <- SpidermiRanalyze_DEnetworkTCGA(data = geneSymb_net, 
                                          TCGAmatrix = dataFilt, 
                                          tumour = samples_TP, 
                                          normal = samples_NT)
```

## Tips and Best Practices
- **Species Selection**: Always use `SpidermiRquery_species` first to ensure you have the correct internal ID for your organism.
- **Network Types**: Use `SHpd` for shared protein domains and `PHint` for physical interactions; these are the most common starting points for miRNA integration.
- **Memory Management**: GeneMania networks can be very large. Use `SpidermiRprepare_NET` to clean and deduplicate the data early in your script.
- **Visualization**: While SpidermiR has internal visualization functions, the output data frames are compatible with `igraph` and `networkD3` for custom plotting.

## Reference documentation
- [SpidermiR: Application Examples](./references/SpidermiRcasestudy.md)