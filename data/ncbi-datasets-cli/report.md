# ncbi-datasets-cli CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ncbi-datasets-cli_datasets_download_gene | PASS |  |
| ncbi-datasets-cli_datasets_download_genome | PASS |  |
| ncbi-datasets-cli_datasets_summary_gene | PASS |  |
| ncbi-datasets-cli_datasets_summary_genome | PASS |  |
| ncbi-datasets-cli_rehydrate | PASS |  |

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

## Metadata
- **Skill**: generated

## ncbi-datasets-cli_datasets_summary_gene

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

## ncbi-datasets-cli_datasets_summary_genome

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

## ncbi-datasets-cli_datasets_download_gene

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

## ncbi-datasets-cli_datasets_download_genome

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
