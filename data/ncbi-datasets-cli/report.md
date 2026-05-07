# ncbi-datasets-cli CWL Generation Report

## ncbi-datasets-cli_summary

### Tool Description
Print a data report containing gene, genome or virus metadata in JSON format.

### Metadata
- **Docker Image**: quay.io/biocontainers/ncbi-datasets-cli:14.26.0
- **Homepage**: https://github.com/metagenlab/assembly_finder
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/ncbi-datasets-cli/overview
- **Total Downloads**: 1.1M
- **Last updated**: 2026-04-30
- **GitHub**: https://github.com/metagenlab/assembly_finder
- **Stars**: N/A
### Original Help Text
```text
Print a data report containing gene, genome or virus metadata in JSON format.

Usage
  datasets summary [flags]
  datasets summary [command]

Sample Commands
  datasets summary genome accession GCF_000001405.40
  datasets summary genome taxon "mus musculus"
  datasets summary gene gene-id 672
  datasets summary gene symbol brca1 --taxon mouse
  datasets summary gene accession NP_000483.3
  datasets summary virus genome accession NC_045512.2
  datasets summary virus genome taxon sars-cov-2 --host dog

Available Commands
  gene        Print a summary of a gene dataset
  genome      Print a data report containing genome metadata
  virus       Print a data report containing virus genome metadata

Global Flags
      --api-key string   Specify an NCBI API key
      --debug            Emit debugging info
      --help             Print detailed help about a datasets command
      --version          Print version of datasets

Use datasets summary <command> --help for detailed help about a command.
```


## ncbi-datasets-cli_download

### Tool Description
Download genome, gene and virus data packages, including sequence, annotation, and metadata, as a zip file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ncbi-datasets-cli:14.26.0
- **Homepage**: https://github.com/metagenlab/assembly_finder
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Download genome, gene and virus data packages, including sequence, annotation, and metadata, as a zip file.

Refer to NCBI's [download and install](https://www.ncbi.nlm.nih.gov/datasets/docs/v2/download-and-install/) documentation for information about getting started with the command-line tools.

Usage
  datasets download [command]

Sample Commands
  datasets download genome accession GCF_000001405.40 --chromosomes X,Y --exclude-gff3 --exclude-rna
  datasets download genome taxon "bos taurus"
  datasets download gene gene-id 672
  datasets download gene symbol brca1 --taxon mouse
  datasets download gene accession NP_000483.3
  datasets download virus genome taxon sars-cov-2 --host dog
  datasets download virus protein S --host dog --filename SARS2-spike-dog.zip

Available Commands
  gene        Download a gene data package
  genome      Download a genome data package
  virus       Download a virus data package

Flags
      --filename string   Specify a custom file name for the downloaded data package (default "ncbi_dataset.zip")
      --no-progressbar    Hide progress bar


Global Flags
      --api-key string   Specify an NCBI API key
      --debug            Emit debugging info
      --help             Print detailed help about a datasets command
      --version          Print version of datasets

Use datasets download <command> --help for detailed help about a command.
```


## ncbi-datasets-cli_rehydrate

### Tool Description
Download data files for an unzipped, dehydrated genome data package. Data files specified in fetch.txt will be downloaded from NCBI.

### Metadata
- **Docker Image**: quay.io/biocontainers/ncbi-datasets-cli:14.26.0
- **Homepage**: https://github.com/metagenlab/assembly_finder
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Download data files for an unzipped, dehydrated genome data package. Data files specified in fetch.txt will be downloaded from NCBI. Read more about how rehydration can help with large genome downloads: https://www.ncbi.nlm.nih.gov/datasets/docs/v2/how-tos/genomes/large-download/

Usage
  datasets rehydrate [flags] --directory <directory_name>

Flags
      --directory string   Specify the directory containing the unzipped dehydrated bag
      --gzip               rehydrate files to gzip format
      --list               List files that would be downloaded during rehydration
      --match string       Specify substring that matches files for rehydration
      --max-workers int    Limit the maximum number of concurrent download workers (allowed range is 1-30) (default 10)


Global Flags
      --api-key string   Specify an NCBI API key
      --debug            Emit debugging info
      --help             Print detailed help about a datasets command
      --version          Print version of datasets
```


## ncbi-datasets-cli_completion

### Tool Description
This sub-command generates files needed to enable auto-complete for several popular command-line interpreters.

### Metadata
- **Docker Image**: quay.io/biocontainers/ncbi-datasets-cli:14.26.0
- **Homepage**: https://github.com/metagenlab/assembly_finder
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
This sub-command generates files needed to enable auto-complete for several popular command-line interpreters.

When enabled, the command-line interpreter can automatically fill in subcommands and options.

A good introduction of command-line completion is found on [wikipedia](https://en.wikipedia.org/wiki/Command-line_completion).

Usage
  datasets completion [command]

Available Commands
  bash        Generate bash autocompletion script
  zsh         Generate zsh autocompletion script
  fish        Generate fish autocompletion script
  powershell  Generate powershell autocompletion script

Global Flags
      --api-key string   Specify an NCBI API key
      --debug            Emit debugging info
      --help             Print detailed help about a datasets command
      --version          Print version of datasets

Use datasets completion <command> --help for detailed help about a command.
```


## dataformat_tsv

### Tool Description
Convert data to TSV format.

### Metadata
- **Docker Image**: quay.io/biocontainers/ncbi-datasets-cli:14.26.0
- **Homepage**: https://github.com/metagenlab/assembly_finder
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Convert data to TSV format.

Refer to NCBI's [download and install](https://www.ncbi.nlm.nih.gov/datasets/docs/v2/download-and-install/) documentation for information about getting started with the command-line tools.

Usage
  dataformat tsv [command]

Report Commands
  genome             Convert Genome Assembly Data Report into TSV format
  genome-seq         Convert Genome Assembly Sequence Report into TSV format
  gene               Convert Gene Report into TSV format
  gene-product       Convert Gene Product Report into TSV format
  virus-genome       Convert Virus Data Report into TSV format
  virus-annotation   Convert Virus Annotation Report into TSV format
  microbigge         Convert MicroBIGG-E Data Report into TSV format
  prok-gene          Convert Prokaryote Gene Report into TSV format
  prok-gene-location Convert Prokaryote Gene Location Report into TSV format
  feature            Convert Feature Data Report into TSV format

Flags
      --elide-header   Do not output header
  -h, --help           help for tsv



Global Flags
      --force   Force dataformat to run without type check prompt

Use dataformat tsv <command> --help for detailed help about a command.
```

## dataformat_excel

### Tool Description
Convert data into an Excel workbook.

### Metadata
- **Docker Image**: quay.io/biocontainers/ncbi-datasets-cli:14.26.0
- **Homepage**: https://github.com/metagenlab/assembly_finder
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Convert data into an Excel workbook.

Refer to NCBI's [download and install](https://www.ncbi.nlm.nih.gov/datasets/docs/v2/download-and-install/) documentation for information about getting started with the command-line tools.

Usage
  dataformat excel [command]

Report Commands
  genome             Convert Genome Assembly Data Report into an Excel workbook
  genome-seq         Convert Genome Assembly Sequence Report into an Excel workbook
  gene               Convert Gene Report into an Excel workbook
  gene-product       Convert Gene Product Report into an Excel workbook
  virus-genome       Convert Virus Data Report into an Excel workbook
  virus-annotation   Convert Virus Annotation Report into an Excel workbook
  microbigge         Convert MicroBIGG-E Data Report into an Excel workbook
  prok-gene          Convert Prokaryote Gene Report into an Excel workbook
  prok-gene-location Convert Prokaryote Gene Location Report into an Excel workbook
  feature            Convert Feature Data Report into an Excel workbook

Flags
  -h, --help                help for excel
      --outputfile string   Excel workbook file



Global Flags
      --force   Force dataformat to run without type check prompt

Use dataformat excel <command> --help for detailed help about a command.
```

## Metadata
- **Skill**: generated
