---
name: viguno
description: Viguno bridges genetic data with clinical ontologies, managing HPO phenotypes and disease relationships. Use when user asks to download HPO data, convert ontology files to binary format, deploy the Viguno server, perform phenotype lookups, or calculate phenotype similarity.
homepage: https://github.com/bihealth/viguno
---


# viguno

## Overview
Viguno (Versatile Interface for Genetics Utilization of Nice Ontologies) serves as a specialized bridge between genetic data and clinical ontologies. It is primarily used to handle HPO phenotypes and disease relationships, providing both a high-performance REST API and CLI utilities for data preparation. Use this skill to assist with downloading HPO data, converting text-based ontology files into optimized binary formats, and deploying the Viguno server for interactive API access.

## Data Preparation Workflow
Before running the server, you must prepare the HPO and HGNC cross-link data.

### 1. Downloading HPO Data
Fetch the required ontology and mapping files from the official HPO releases:
```bash
RELEASE=2023-06-06
URL=https://github.com/obophenotype/human-phenotype-ontology/releases/download/v$RELEASE
mkdir -p ./data/hpo

# Download core files
wget -O ./data/hpo/hp.obo $URL/hp-base.obo
wget -O ./data/hpo/phenotype.hpoa $URL/phenotype.hpoa
wget -O ./data/hpo/phenotype_to_genes.txt $URL/phenotype_to_genes.txt
wget -O ./data/hpo/genes_to_phenotype.txt $URL/genes_to_phenotype.txt

# Clean up OBO references
sed -i -e 's|/hp-base.owl||' ./data/hpo/hp.obo
```

### 2. Generating HGNC Cross-links
Viguno requires a mapping between HGNC IDs, Ensembl IDs, Entrez IDs, and Gene Symbols:
```bash
wget -O hgnc.json https://ftp.ebi.ac.uk/pub/databases/genenames/hgnc/json/hgnc_complete_set.json

echo -e "hgnc_id\tensembl_gene_id\tentrez_id\tgene_symbol" > ./data/hpo/hgnc_xlink.tsv

jq -r '.response.docs[] | select(.entrez_id != null) | [.hgnc_id, .ensembl_gene_id, .entrez_id, .symbol] | @tsv' hgnc.json \
| LC_ALL=C sort -t $'\t' -k3,3n >> ./data/hpo/hgnc_xlink.tsv
```

### 3. Binary Conversion
To significantly improve server startup time and lookup performance, convert the raw text files into a binary format:
```bash
viguno convert \
  --path-hpo-dir ./data/hpo \
  --path-out-bin ./data/hpo/hpo.bin
```

## Server Operations
Run the Viguno REST API server to enable phenotype lookups and similarity calculations.

### Running the Server
Point the server to your prepared data directory:
```bash
viguno server run \
  --path-hpo-dir ./data/hpo \
  --listen-host 127.0.0.1 \
  --listen-port 8080
```

### Interactive Documentation
Once the server is running, access the Swagger UI for interactive API testing and endpoint exploration:
- **URL**: `http://127.0.0.1:8080/swagger-ui/`

## Docker Usage
If the local binary is unavailable, use the official Docker image. Ensure you bind-mount your data directory:
```bash
docker run \
  -v $(pwd)/data:/data \
  -p 8080:8080 \
  -it ghcr.io/varfish-org/viguno:0.4.0 \
  viguno server run --path-hpo-dir /data/hpo --listen-host 0.0.0.0
```

## Reference documentation
- [Viguno GitHub Repository](./references/github_com_varfish-org_viguno.md)