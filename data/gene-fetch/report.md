# gene-fetch CWL Generation Report

## gene-fetch

### Tool Description
Fetch gene and/or protein sequences from the NCBI GenBank database.

### Metadata
- **Docker Image**: quay.io/biocontainers/gene-fetch:1.0.21--pyhdfd78af_0
- **Homepage**: https://github.com/bge-barcoding/gene_fetch
- **Package**: https://anaconda.org/channels/bioconda/packages/gene-fetch/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gene-fetch/overview
- **Total Downloads**: 882
- **Last updated**: 2025-12-13
- **GitHub**: https://github.com/bge-barcoding/gene_fetch
- **Stars**: N/A
### Original Help Text
```text
======   Starting Gene Fetch   ======
Version: 1.0.21
Written by Dan Parsons & Ben Price, Natural History Museum London

usage: gene-fetch [-h] [--version] --gene GENE --out OUT (--in INPUT_CSV |
                  --in2 INPUT_TAXONOMY_CSV | --single SINGLE)
                  --type {protein,nucleotide,both}
                  [--protein-size PROTEIN_SIZE]
                  [--nucleotide-size NUCLEOTIDE_SIZE] --email EMAIL
                  --api-key API_KEY [--max-sequences MAX_SEQUENCES]
                  [--genbank] [--clean] [--header {basic,detailed}]

Fetch gene and/or protein sequences from the NCBI GenBank database.

options:
  -h, --help            show this help message and exit
  --version             Show version information and exit
  --gene, -g GENE       Name of gene to search for in NCBI RefSeq database
                        (e.g., cox1, coi, co1)
  --out, -o OUT         Path to directory to save output files (will create
                        new directories)
  --in, -i INPUT_CSV    Path to input CSV file containing taxIDs (must have
                        columns "taxID" and "ID")
  --in2, -i2 INPUT_TAXONOMY_CSV
                        Path to input CSV file containing taxonomic
                        information (must have columns "ID", "phylum",
                        "class", "order", "family", "genus", "species")
  --single, -s SINGLE   Single taxID to search and fetch (e.g., 7227)
  --type, -t {protein,nucleotide,both}
                        Specify sequence type to fetch (protein / nucleotide
                        coding sequence / both)
  --protein-size, -ps PROTEIN_SIZE
                        Minimum protein sequence length (default: 500. Can be
                        bypassed by setting to zero/a negative number)
  --nucleotide-size, -ns NUCLEOTIDE_SIZE
                        Minimum nucleotide sequence length(default: 1000. Can
                        be bypassed by setting to zero/a negative number)
  --email, -e EMAIL     Email to use for NCBI API requests (required)
  --api-key, -k API_KEY
                        API key to use for NCBI API requests (required)
  --max-sequences, -ms MAX_SEQUENCES
                        Maximum number of sequences to fetch (only works with
                        -s/--single)
  --genbank, -gb        Download GenBank (.gb) files corresponding to fetched
                        sequences
  --clean, -c           Force clean start - clear output directory regardless
                        of previous run parameters
  --header {basic,detailed}
                        FASTA header format: 'basic' (ID only, default) or
                        'detailed' (ID|taxid|accession|description|length)
```

