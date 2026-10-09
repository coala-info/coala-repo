# konezumiaid CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| konezumiaid | PASS | new CWL for the default gene search (--name); Rp1 gRNAs match the README example |
| konezumiaid_batch | PASS | ran on a 2-gene list (Rp1, Xkr4); Rp1 gRNAs match the README example; added dataset input and output folder |
| konezumiaid_preprocess | PASS | ran on the repo example refFlat (Xkr4, Rp1) with real mm39 chr1 sequence (truncated prefix from UCSC); wrote the dataset pickles; added required .fai index and dataset output |

## konezumiaid_preprocess

### Tool Description
Preprocesses data for konezumiaid.

### Metadata
- **Docker Image**: quay.io/biocontainers/konezumiaid:0.3.6.1--pyhdfd78af_0
- **Homepage**: https://github.com/aki2274/KOnezumi-AID
- **Package**: https://anaconda.org/channels/bioconda/packages/konezumiaid/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/konezumiaid/overview
- **Total Downloads**: 3.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/aki2274/KOnezumi-AID
- **Stars**: N/A
### Original Help Text
```text
usage: konezumiaid preprocess [-h] refflat_path chromosome_fasta_path

positional arguments:
  refflat_path          Path to the refFlat text file.
  chromosome_fasta_path
                        Path to the chromosome fasta file.(e.g. mm39.fa)

options:
  -h, --help            show this help message and exit
```


## konezumiaid_batch

### Tool Description
N/A

### Metadata
- **Docker Image**: quay.io/biocontainers/konezumiaid:0.3.6.1--pyhdfd78af_0
- **Homepage**: https://github.com/aki2274/KOnezumi-AID
- **Package**: https://anaconda.org/channels/bioconda/packages/konezumiaid/overview
- **Validation**: PASS

### Original Help Text
```text
usage: konezumiaid batch [-h] -f FILE

options:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  Path to the gene CSV or Excel file
```


## konezumiaid

### Tool Description
Designs gRNAs for multiplex KO mouse with Target-AID; searches PTC and splice-site gRNA candidates for one gene symbol or RefSeq transcript (needs `konezumiaid preprocess` first).

### Metadata
- **Docker Image**: quay.io/biocontainers/konezumiaid:0.3.6.1--pyhdfd78af_0
- **Homepage**: https://github.com/aki2274/KOnezumi-AID
- **Package**: https://anaconda.org/channels/bioconda/packages/konezumiaid/overview
- **Validation**: PASS

### Original Help Text
```text
usage: konezumiaid [-h] [-n NAME] [-v] {preprocess,batch} ...

This is KonezumiAID. A software to automate the design of gRNA for multiplex
KO mouse using Target-AID

positional arguments:
  {preprocess,batch}
    preprocess          Format and export the dataset as pickle files.
    batch               Batch processing for multiple genes.

options:
  -h, --help            show this help message and exit
  -n NAME, --name NAME  Gene name or transcript name (Refseq ID) you want to.
  -v, --version         show program's version number and exit
```


## Metadata
- **Skill**: generated
