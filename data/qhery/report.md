# qhery CWL Generation Report

## qhery_list_rx

### Tool Description
List resistance genes from the Stanford resistance database.

### Metadata
- **Docker Image**: quay.io/biocontainers/qhery:0.1.2--pyhdfd78af_0
- **Homepage**: http://github.com/mjsull/qhery/
- **Package**: https://anaconda.org/channels/bioconda/packages/qhery/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/qhery/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mjsull/qhery
- **Stars**: N/A
### Original Help Text
```text
usage: qhery list_rx [-h] [--database_dir DATABASE_DIR]

options:
  -h, --help            show this help message and exit
  --database_dir DATABASE_DIR, -d DATABASE_DIR
                        Directory with latest Stanford resistance database.
```


## qhery_run

### Tool Description
Run the QHERY pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/qhery:0.1.2--pyhdfd78af_0
- **Homepage**: http://github.com/mjsull/qhery/
- **Package**: https://anaconda.org/channels/bioconda/packages/qhery/overview
- **Validation**: PASS

### Original Help Text
```text
usage: qhery run [-h] --sample_name SAMPLE_NAME [--vcf VCF] [--bam BAM]
                 --database_dir DATABASE_DIR [--download] --pipeline_dir
                 PIPELINE_DIR [--lineage LINEAGE]
                 [--rx_list RX_LIST [RX_LIST ...]] [--fasta FASTA]
                 [--download_nextclade_data] [--nextclade_data NEXTCLADE_DATA]

options:
  -h, --help            show this help message and exit
  --sample_name SAMPLE_NAME, -n SAMPLE_NAME
                        Sample name.
  --vcf VCF, -v VCF     vcf file
  --bam BAM, -b BAM     bam file
  --database_dir DATABASE_DIR, -d DATABASE_DIR
                        Directory with latest Stanford resistance database.
  --download            Download the latest database.
  --pipeline_dir PIPELINE_DIR, -p PIPELINE_DIR
                        Pipeline to run program in.
  --lineage LINEAGE, -l LINEAGE
                        Lineage report of variants.
  --rx_list RX_LIST [RX_LIST ...], -rx RX_LIST [RX_LIST ...]
                        List of drugs to analyze.
  --fasta FASTA, -f FASTA
                        Consensus fasta.
  --download_nextclade_data, -dn
                        download nextclade data.
  --nextclade_data NEXTCLADE_DATA, -nd NEXTCLADE_DATA
                        directory of sars-cov-2 nextclade data, can be
                        downloaded with "nextclade dataset get --name 'sars-
                        cov-2' --output-dir 'data/sars-cov-2'"
```


## qhery_mutations

### Tool Description
Analyze mutations using the qhery tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/qhery:0.1.2--pyhdfd78af_0
- **Homepage**: http://github.com/mjsull/qhery/
- **Package**: https://anaconda.org/channels/bioconda/packages/qhery/overview
- **Validation**: PASS

### Original Help Text
```text
usage: qhery mutations [-h] [--vcf VCF] [--database_dir DATABASE_DIR]
                       [--pipeline_dir PIPELINE_DIR] [--lineage LINEAGE]
                       [--sample_name SAMPLE_NAME] [--bam BAM]

options:
  -h, --help            show this help message and exit
  --vcf VCF, -v VCF     List of VCF files
  --database_dir DATABASE_DIR, -d DATABASE_DIR
                        Directory with latest Stanford resistance database.
  --pipeline_dir PIPELINE_DIR, -p PIPELINE_DIR
                        Pipeline to run program in.
  --lineage LINEAGE, -l LINEAGE
                        Lineage report of variants.
  --sample_name SAMPLE_NAME, -n SAMPLE_NAME
                        Sample name.
  --bam BAM, -b BAM     bam file
```


## Metadata
- **Skill**: generated
