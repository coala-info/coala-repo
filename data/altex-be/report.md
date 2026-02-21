# altex-be CWL Generation Report

## altex-be

### Tool Description
Altex BE: A CLI tool for processing refFlat files and extracting target exons.

### Metadata
- **Docker Image**: quay.io/biocontainers/altex-be:1.0.5--pyhdfd78af_0
- **Homepage**: https://github.com/kinari-labwork/AltEx-BE
- **Package**: https://anaconda.org/channels/bioconda/packages/altex-be/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/altex-be/overview
- **Total Downloads**: 244
- **Last updated**: 2026-01-06
- **GitHub**: https://github.com/kinari-labwork/AltEx-BE
- **Stars**: N/A
### Original Help Text
```text
usage: altex-be [-h] [-v] [-r REFFLAT_PATH | -g GTF_PATH] -f FASTA_PATH -o
                OUTPUT_DIR [--gene-symbols GENE_SYMBOLS [GENE_SYMBOLS ...]]
                [--refseq-ids REFSEQ_IDS [REFSEQ_IDS ...]]
                [--ensembl-ids ENSEMBL_IDS [ENSEMBL_IDS ...]] -a ASSEMBLY_NAME
                [--gene-file GENE_FILE] [-n BE_NAME] [-p BE_PAM] [-s BE_START]
                [-e BE_END] [-t BE_TYPE] [--be-files BE_FILES]

Altex BE: A CLI tool for processing refFlat files and extracting target exons.

options:
  -h, --help            show this help message and exit
  -v, --version         Show the version of Altex BE
  -r REFFLAT_PATH, --refflat-path REFFLAT_PATH
                        Path of refflat file
  -g GTF_PATH, --gtf-path GTF_PATH
                        Path of GTF file

Input/Output Options:
  -f FASTA_PATH, --fasta-path FASTA_PATH
                        Path of FASTA file
  -o OUTPUT_DIR, --output-dir OUTPUT_DIR
                        Directory of the output files

Gene Options:
  --gene-symbols GENE_SYMBOLS [GENE_SYMBOLS ...]
                        List of interest gene symbols (space-separated)
  --refseq-ids REFSEQ_IDS [REFSEQ_IDS ...]
                        List of interest gene Refseq IDs (space-separated)
  --ensembl-ids ENSEMBL_IDS [ENSEMBL_IDS ...]
                        List of interest gene Ensembl IDs (space-separated)
  -a ASSEMBLY_NAME, --assembly-name ASSEMBLY_NAME
                        Name of the genome assembly to use
  --gene-file GENE_FILE
                        Path to a file (csv,txt,tsv) containing gene symbols
                        or IDs correspond to reference of transcript (one per
                        line)

Base Editor Options:
  -n BE_NAME, --be-name BE_NAME
                        Name of the base editor to optional use
  -p BE_PAM, --be-pam BE_PAM
                        PAM sequence for the base editor
  -s BE_START, --be-start BE_START
                        Window start for the base editor (Count from next to
                        PAM)
  -e BE_END, --be-end BE_END
                        Window end for the base editor (Count from next to
                        PAM)
  -t BE_TYPE, --be-type BE_TYPE
                        Choose the type of base editor, this tool supports ABE
                        and CBE
  --be-files BE_FILES   input the path of csv file or txt file of base editor
                        information
```

