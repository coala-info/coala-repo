# atol-qc-annotation CWL Generation Report

## atol-qc-annotation

### Tool Description
Performs quality control and annotation for genome assemblies.

### Metadata
- **Docker Image**: quay.io/biocontainers/atol-qc-annotation:0.1.4--pyhdfd78af_0
- **Homepage**: https://github.com/TomHarrop/atol-qc-annotation
- **Package**: https://anaconda.org/channels/bioconda/packages/atol-qc-annotation/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/atol-qc-annotation/overview
- **Total Downloads**: 220
- **Last updated**: 2025-12-12
- **GitHub**: https://github.com/TomHarrop/atol-qc-annotation
- **Stars**: N/A
### Original Help Text
```text
usage: atol-qc-annotation [-h] [-t THREADS] [-m MEM_GB]
                          [--dev_container DEV_CONTAINER] [-n] --fasta FASTA
                          [--annot ANNOT_FILE] --lineage_dataset
                          LINEAGE_DATASET --lineages_path LINEAGES_PATH --db
                          OMAMER_DB --taxid TAXID --ete_ncbi_db ETE_NCBI_DB
                          --outdir OUTDIR [--logs LOGS_DIRECTORY]

options:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
  -m MEM_GB, --mem MEM_GB
                        Intended maximum RAM in GB.
  --dev_container DEV_CONTAINER
                        For development use. Specify a container to run all
                        the jobs in.
  -n                    Dry run

Input:
  --fasta FASTA, -f FASTA
                        Path to the genome assembly FASTA file
  --annot ANNOT_FILE    Path to the genome annotation file. Any annotation
                        format recognised by agat_sp_extract_sequences works.

BUSCO settings:
  --lineage_dataset LINEAGE_DATASET, -l LINEAGE_DATASET
                        Specify the name of the BUSCO lineage to be used.
                        Default: eukaryota_odb10
  --lineages_path LINEAGES_PATH
                        Path to the BUSCO lineages directory.

OMArk settings:
  --db OMAMER_DB        OMAmer database
  --taxid TAXID         NCBI Taxonomy ID
  --ete_ncbi_db ETE_NCBI_DB
                        Path to the ete3 NCBI database to be used.

Output:
  --outdir OUTDIR       Output directory
  --logs LOGS_DIRECTORY
                        Log output directory. Default: logs are discarded.
```

