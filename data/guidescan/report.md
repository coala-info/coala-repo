# guidescan CWL Generation Report

## guidescan_enumerate

### Tool Description
Enumerates off-targets against a reference.

### Metadata
- **Docker Image**: quay.io/biocontainers/guidescan:2.2.1--h4ac6f70_2
- **Homepage**: https://github.com/pritykinlab/guidescan-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/guidescan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/guidescan/overview
- **Total Downloads**: 28.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pritykinlab/guidescan-cli
- **Stars**: N/A
### Original Help Text
```text
ERROR: RequiredError: --kmers-file is required
Enumerates off-targets against a reference.
Usage: guidescan enumerate [OPTIONS] index

Positionals:
  index TEXT REQUIRED         Prefix for index files

Options:
  -h,--help                   Print this help message and exit
  --start                     Match PAM at start of kmer instead at end (default).
  --max-off-targets INT=-1    Maximum number of off-targets to store for each number of mismatches.
  -n,--threads UINT=20        Number of threads to parallelize over
  -a,--alt-pam TEXT=[] ...    Alternative PAMs used to find off-targets
  -m,--mismatches UINT=3      Number of mismatches to allow when finding off-targets
  --rna-bulges UINT=0         Max number of RNA bulges to allow when finding off-targets
  --dna-bulges UINT=0         Number of DNA bulges to allow when finding off-targets
  -t,--threshold INT=-1       Filters gRNAs with off-targets at a distance at or below this threshold
  --format TEXT:{csv,sam}     File format for output. Choices are ['csv', 'sam'].
  --mode TEXT:{succinct,complete}
                              Information to output. Choices are ['succinct', 'complete'].
  -f,--kmers-file TEXT:FILE REQUIRED
                              File containing kmers to build gRNA database over, if not specified, will generate the database over all kmers with the given PAM
  -o,--output TEXT REQUIRED   Output file.
```


## guidescan_index

### Tool Description
Builds an genomic index over a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/guidescan:2.2.1--h4ac6f70_2
- **Homepage**: https://github.com/pritykinlab/guidescan-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/guidescan/overview
- **Validation**: PASS

### Original Help Text
```text
ERROR: RequiredError: genome is required
Builds an genomic index over a FASTA file.
Usage: guidescan index [OPTIONS] genome

Positionals:
  genome TEXT:FILE REQUIRED   Genome in FASTA format

Options:
  -h,--help                   Print this help message and exit
  --index TEXT                Genomic index prefix.
```


## guidescan_download

### Tool Description
Downloads GuideScan data over HTTP.

### Metadata
- **Docker Image**: quay.io/biocontainers/guidescan:2.2.1--h4ac6f70_2
- **Homepage**: https://github.com/pritykinlab/guidescan-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/guidescan/overview
- **Validation**: PASS

### Original Help Text
```text
ERROR: download: The following argument was not expected: --h
Downloads GuideScan data over HTTP.
Usage: guidescan download [OPTIONS]

Options:
  -h,--help                   Print this help message and exit
  --download-url TEXT=http://guidescan.com:8000/download
                              Endpoint for Download API
  --type TEXT                 Download Type
  --item TEXT                 Download Item
  --output-directory TEXT:DIR=.
                              Output Directory
  --show TEXT:{type,item}     Show Options for type or item
```


## Metadata
- **Skill**: not generated
