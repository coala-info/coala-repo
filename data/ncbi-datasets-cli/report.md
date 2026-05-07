# ncbi-datasets-cli CWL Generation Report

## ncbi-datasets-cli_summary

### Tool Description
Print a data report containing gene, genome or virus metadata in JSON format.

### Metadata
- **Docker Image**: ensemblorg/datasets-cli:v18.25.1
- **Homepage**: https://www.ncbi.nlm.nih.gov/datasets/docs/v2/how-tos/
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/ncbi-datasets-cli/overview
- **Total Downloads**: 1.1M
- **Last updated**: 2026-04-30
- **GitHub**: https://github.com/ncbi/datasets
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
- **Docker Image**: ensemblorg/datasets-cli:latest
- **Homepage**: https://github.com/ncbi/datasets
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
- **Docker Image**: ensemblorg/datasets-cli:latest
- **Homepage**: https://github.com/ncbi/datasets
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
- **Docker Image**: ensemblorg/datasets-cli:latest
- **Homepage**: https://github.com/ncbi/datasets
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
- **Docker Image**: ensemblorg/datasets-cli:latest
- **Homepage**: https://github.com/ncbi/datasets
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
- **Docker Image**: ensemblorg/datasets-cli:latest
- **Homepage**: https://github.com/ncbi/datasets
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

## datasets_summary_gene

### Tool Description
Print a data report containing gene metadata. The data report is returned in JSON format.

### Metadata
- **Docker Image**: ensemblorg/datasets-cli:latest
- **Homepage**: https://github.com/ncbi/datasets
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Print a data report containing gene metadata.  The data report is returned in JSON format.

Usage
  datasets summary gene [flags]
  datasets summary gene [command]

Sample Commands
  datasets summary gene gene-id 672
  datasets summary gene symbol brca1 --taxon mouse
  datasets summary gene accession NP_000483.3

Available Commands
  gene-id     Print a data report containing gene metadata by NCBI Gene ID
  symbol      Print a data report containing gene metadata by gene symbol
  accession   Print a data report containing gene metadata by RefSeq nucleotide or protein accession
  taxon       Print a data report containing gene metadata by taxon (NCBI Taxonomy ID, scientific or common name at any tax rank)

Flags
      --as-json-lines   Stream results as newline delimited JSON-Lines
      --limit string    Limit the number of gene summaries returned
                          * all:      returns all matching gene summaries
                          * a number: returns the specified number of matching gene summaries
                             (default "all")
      --report string   Choose the output type:
                          * gene:     Retrieve the primary gene report
                          * product:  Retrieve product data report
                          * ids_only: Only retrieve gene-ids
                             (default "complete")


Global Flags
      --api-key string   Specify an NCBI API key
      --debug            Emit debugging info
      --help             Print detailed help about a datasets command
      --version          Print version of datasets

Use datasets summary gene <command> --help for detailed help about a command.
```

## datasets_summary_genome

### Tool Description
Print a data report containing genome metadata. The data report is returned in JSON format.

### Metadata
- **Docker Image**: ensemblorg/datasets-cli:latest
- **Homepage**: https://github.com/ncbi/datasets
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Print a data report containing genome metadata. The data report is returned in JSON format.

Usage
  datasets summary genome [flags]
  datasets summary genome [command]

Sample Commands
  datasets summary genome accession GCF_000001405.40
  datasets summary genome taxon mouse
  datasets summary genome taxon human --assembly-level chromosome,complete
  datasets summary genome taxon mouse --search C57BL/6J --search "Broad Institute"

Available Commands
  accession   Print a data report containing genome metadata by Assembly or BioProject accession
  taxon       Print a data report containing genome metadata by taxon (NCBI Taxonomy ID, scientific or common name at any tax rank)

Flags
      --annotated                Limit to annotated genomes
      --as-json-lines            Output results in JSON Lines format
      --assembly-level string    Limit to genomes at one or more assembly levels (comma-separated):
                                   * chromosome
                                   * complete
                                   * contig
                                   * scaffold
                                    (default "[]")
      --assembly-source string   Limit to 'RefSeq' (GCF_) or 'GenBank' (GCA_) genomes (default "all")
      --exclude-atypical         Exclude atypical assemblies
      --limit string             Limit the number of genome summaries returned
                                   * all:      returns all matching genome summaries
                                   * a number: returns the specified number of matching genome summaries
                                      (default "all")
      --mag string               Limit to metagenome assembled genomes (only) or remove them from the results (exclude) (default "all")
      --reference                Limit to reference genomes
      --released-after string    Limit to genomes released on or after a specified date (MM/DD/YYYY)
      --released-before string   Limit to genomes released on or before a specified date (MM/DD/YYYY)
      --report string            Choose the output type:
                                   * genome:   Retrieve the primary genome report
                                   * sequence: Retrieve the sequence report
                                   * ids_only: Retrieve only the genome identifiers
                                    (default "genome")
      --search strings           Limit results to genomes with specified text in the searchable fields:
                                 species and infraspecies, assembly name and submitter.
                                 To search multiple strings, use the flag multiple times.


Global Flags
      --api-key string   Specify an NCBI API key
      --debug            Emit debugging info
      --help             Print detailed help about a datasets command
      --version          Print version of datasets

Use datasets summary genome <command> --help for detailed help about a command.
```

## datasets_summary_virus

### Tool Description
Print a data report containing virus genome metadata by accession or taxon. The data report is returned in JSON format.

### Metadata
- **Docker Image**: ensemblorg/datasets-cli:latest
- **Homepage**: https://github.com/ncbi/datasets
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Print a data report containing virus genome metadata by accession or taxon. The data report is returned in JSON format.

Usage
  datasets summary virus [flags]
  datasets summary virus [command]

Available Commands
  genome      Print a data report containing virus genome metadata by accession or taxon

Global Flags
      --api-key string   Specify an NCBI API key
      --debug            Emit debugging info
      --help             Print detailed help about a datasets command
      --version          Print version of datasets

Use datasets summary virus <command> --help for detailed help about a command.
```

## datasets_download_virus

### Tool Description
Download a virus genome or SARS-CoV-2 protein data package as a zip file.

### Metadata
- **Docker Image**: ensemblorg/datasets-cli:latest
- **Homepage**: https://github.com/ncbi/datasets
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Download a virus genome or SARS-CoV-2 protein data package as a zip file.

Usage
  datasets download virus [flags]
  datasets download virus [command]

Sample Commands
  datasets download virus genome taxon sars-cov-2 --host dog
  datasets download virus protein S --host dog --filename SARS2-spike-dog.zip

Available Commands
  genome      Download a virus genome dataset by accession or taxon
  protein     Download a SARS-CoV-2 protein dataset by protein name

Global Flags
      --api-key string    Specify an NCBI API key
      --debug             Emit debugging info
      --filename string   Specify a custom file name for the downloaded data package (default "ncbi_dataset.zip")
      --help              Print detailed help about a datasets command
      --no-progressbar    Hide progress bar
      --version           Print version of datasets

Use datasets download virus <command> --help for detailed help about a command.
```

## datasets_download_gene

### Tool Description
Download a gene data package. Gene data packages include gene, transcript and protein sequences and one or more data reports. Data packages are downloaded as a zip archive.

### Metadata
- **Docker Image**: ensemblorg/datasets-cli:latest
- **Homepage**: https://github.com/ncbi/datasets
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Download a gene data package.  Gene data packages include gene, transcript and protein sequences and one or more data reports. Data packages are downloaded as a zip archive.

The default gene data package for NM, NR, NP, XM, XR, XP and YP accessions:
  * rna.fna (transcript sequences)
  * protein.faa (protein sequences)
  * data_report.jsonl (data report with gene metadata)
  * dataset_catalog.json (a list of files and file types included in the data package)

Usage
  datasets download gene [flags]
  datasets download gene [command]

Sample Commands
  datasets download gene gene-id 672
  datasets download gene symbol brca1 --taxon mouse
  datasets download gene accession NP_000483.3
  datasets download gene gene-id 2778 --fasta-filter NC_000020.11,NM_001077490.3,NP_001070958.1

Available Commands
  gene-id     Download a gene data package by NCBI Gene ID
  symbol      Download a gene data package by gene symbol
  accession   Download a gene data package by RefSeq nucleotide or protein accession
  taxon       Download a gene data package by taxon (NCBI Taxonomy ID, scientific or common name at any tax rank)

Flags
      --fasta-filter strings       Limit protein and RNA sequence files to the specified RefSeq nucleotide and protein accessions
      --fasta-filter-file string   Limit protein and RNA sequence files to the specified RefSeq nucleotide and protein accessions included in the specified file
      --preview                    Show information about the requested data package


Global Flags
      --api-key string    Specify an NCBI API key
      --debug             Emit debugging info
      --filename string   Specify a custom file name for the downloaded data package (default "ncbi_dataset.zip")
      --help              Print detailed help about a datasets command
      --no-progressbar    Hide progress bar
      --version           Print version of datasets

Use datasets download gene <command> --help for detailed help about a command.
```

## datasets_download_genome

### Tool Description
Download a genome data package. Genome data packages may include genome, transcript and protein sequences, annotation and one or more data reports. Data packages are downloaded as a zip archive.

### Metadata
- **Docker Image**: ensemblorg/datasets-cli:latest
- **Homepage**: https://github.com/ncbi/datasets
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Download a genome data package. Genome data packages may include genome, transcript and protein sequences, annotation and one or more data reports. Data packages are downloaded as a zip archive.

The default genome data package includes the following files:
  * <accession>_<assembly_name>_genomic.fna (genomic sequences)
  * assembly_data_report.jsonl (data report with genome assembly and annotation metadata)
  * dataset_catalog.json (a list of files and file types included in the data package)

Usage
  datasets download genome [flags]
  datasets download genome [command]

Sample Commands
  datasets download genome accession GCF_000001405.40 --chromosomes X,Y --include genome,gff3,rna
  datasets download genome taxon "bos taurus" --dehydrated
  datasets download genome taxon human --assembly-level chromosome,complete --dehydrated
  datasets download genome taxon mouse --search C57BL/6J --search "Broad Institute" --dehydrated

Available Commands
  accession   Download a genome data package by Assembly or BioProject accession
  taxon       Download a genome data package by taxon (NCBI Taxonomy ID, scientific or common name at any tax rank)

Flags
      --annotated                Limit to annotated genomes
      --assembly-level string    Limit to genomes at one or more assembly levels (comma-separated):
                                   * chromosome
                                   * complete
                                   * contig
                                   * scaffold
                                    (default "[]")
      --assembly-source string   Limit to 'RefSeq' (GCF_) or 'GenBank' (GCA_) genomes (default "all")
      --chromosomes strings      Limit to a specified, comma-delimited list of chromosomes, or 'all' for all chromosomes
      --dehydrated               Download a dehydrated zip archive including the data report and locations of data files (use the rehydrate command to retrieve data files).
      --exclude-atypical         Exclude atypical assemblies
      --mag string               Limit to metagenome assembled genomes (only) or remove them from the results (exclude) (default "all")
      --preview                  Show information about the requested data package
      --reference                Limit to reference genomes
      --released-after string    Limit to genomes released on or after a specified date (MM/DD/YYYY)
      --released-before string   Limit to genomes released on or before a specified date (MM/DD/YYYY)
      --search strings           Limit results to genomes with specified text in the searchable fields:
                                 species and infraspecies, assembly name and submitter.
                                 To search multiple strings, use the flag multiple times.


Global Flags
      --api-key string    Specify an NCBI API key
      --debug             Emit debugging info
      --filename string   Specify a custom file name for the downloaded data package (default "ncbi_dataset.zip")
      --help              Print detailed help about a datasets command
      --no-progressbar    Hide progress bar
      --version           Print version of datasets

Use datasets download genome <command> --help for detailed help about a command.
```
