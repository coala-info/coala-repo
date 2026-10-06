# bactopia CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bactopia_atb_downloader | Not completed | The default All-the-Bacteria file list URL (osf.io/download/4yv85) now returns 404, and a real download needs multi-GB tar.xz archives. |
| bactopia_atb_formatter | PASS |  |
| bactopia_datasets | Not completed | Downloads all optional Bactopia datasets (multi-GB), too large for this test. |
| bactopia_prepare | PASS |  |
| bactopia_pubmlst_build | Not completed | Needs a PubMLST API token made by bactopia-pubmlst-setup with real credentials. |
| bactopia_pubmlst_setup | Not completed | Needs a PubMLST or Pasteur OAuth client ID and secret (credentials). |
| bactopia_search | PASS |  |
| bactopia_summary | Not completed | No real Bactopia results folder is available; the tool needs per-sample QC, assembly and annotation outputs from a full Bactopia pipeline run, and an assembly-only folder gives 'No samples found to process'. |

## bactopia_prepare

### Tool Description
Create a 'file of filenames' (FOFN) of samples to be processed by Bactopia

### Metadata
- **Docker Image**: quay.io/biocontainers/bactopia:3.2.0--hdfd78af_0
- **Homepage**: https://github.com/bactopia/bactopia
- **Package**: https://anaconda.org/channels/bioconda/packages/bactopia/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bactopia/overview
- **Total Downloads**: 226.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bactopia/bactopia
- **Stars**: N/A
### Original Help Text
```text

 Usage: bactopia-prepare [OPTIONS]

 Create a 'file of filenames' (FOFN) of samples to be processed by Bactopia

╭─ Required Options ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *  --path  -p  TEXT  Directory where FASTQ files are stored [required]                                                                   │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Matching Options ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --assembly-ext     -a  TEXT  Extension of the FASTA assemblies [default: .fna.gz]                                                        │
│ --fastq-ext        -f  TEXT  Extension of the FASTQs [default: .fastq.gz]                                                                │
│ --fastq-separator      TEXT  Split FASTQ name on the last occurrence of the separator [default: _]                                       │
│ --pe1-pattern          TEXT  Designates difference first set of paired-end reads [default: [Aa]|[Rr]1|1]                                 │
│ --pe2-pattern          TEXT  Designates difference second set of paired-end reads [default: [Bb]|[Rr]2|2]                                │
│ --merge                      Flag samples with multiple read sets to be merged by Bactopia                                               │
│ --ont                        Single-end reads should be treated as Oxford Nanopore reads                                                 │
│ --hybrid                     Samples with paired and single-end reads will be set to Illumina-first hybrid assembly (requires --ont)     │
│ --short-polish               Samples with paired and single-end reads will be set to Nanopore-first hybrid assembly (requires --ont)     │
│ --recursive        -r        Directories will be traversed recursively                                                                   │
│ --prefix               TEXT  Prefix to add to the path                                                                                   │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Sample Information Options ─────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --metadata             TEXT     Metadata per sample with genome size and species information                                             │
│ --genome-size  -gsize  INTEGER  Genome size to use for all samples                                                                       │
│ --species      -s      TEXT     Species to use for all samples (If available, can be used to determine genome size)                      │
│ --taxid                TEXT     Use the genome size of the Taxon ID for all samples                                                      │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Additional Options ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --examples        Print example usage                                                                                                    │
│ --verbose         Increase the verbosity of output                                                                                       │
│ --silent          Only critical errors will be printed                                                                                   │
│ --version   -V    Show the version and exit.                                                                                             │
│ --help            Show this message and exit.                                                                                            │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## bactopia_search

### Tool Description
Query against ENA and SRA for public accessions to process with Bactopia

### Metadata
- **Docker Image**: quay.io/biocontainers/bactopia:3.2.0--hdfd78af_0
- **Homepage**: https://github.com/bactopia/bactopia
- **Package**: https://anaconda.org/channels/bioconda/packages/bactopia/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bactopia/overview
- **Total Downloads**: 226.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bactopia/bactopia
- **Stars**: N/A
### Original Help Text
```text

 Usage: bactopia-search [OPTIONS]

 Query against ENA and SRA for public accessions to process with Bactopia

╭─ Required Options ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *  --query  -q  TEXT  Taxon ID or Study, BioSample, or Run accession (can also be comma separated or a file of accessions) [required]    │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Query Options ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --exact-taxon                     Exclude Taxon ID descendants                                                                           │
│ --limit             -l   INTEGER  Maximum number of results (per query) to return [default: 1000000]                                     │
│ --accession-limit   -al  INTEGER  Maximum number of accessions to query at once [default: 5000]                                          │
│ --biosample-subset       INTEGER  If a BioSample has multiple Experiments, maximum number to randomly select (0 = disabled) [default: 0] │
│ --include-empty                   Include metadata columns that are empty for all rows                                                   │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Filtering Options ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --min-base-count   -mbc  INTEGER  Filters samples based on minimum base pair count (0 = disabled) [default: 0]                           │
│ --min-read-length  -mrl  INTEGER  Filters samples based on minimum mean read length (0 = disabled) [default: 0]                          │
│ --min-coverage     -mc   INTEGER  Filter samples based on minimum coverage (requires --genome_size, 0 = disabled) [default: 0]           │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Additional Options ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --genome-size  -gsize  INTEGER  Genome size to be used for all samples, and for calculating min coverage [default: 0]                    │
│ --outdir       -o      TEXT     Directory to write output [default: ./]                                                                  │
│ --prefix       -p      TEXT     Prefix to use for output file names [default: bactopia]                                                  │
│ --force                         Overwrite existing reports                                                                               │
│ --verbose                       Increase the verbosity of output                                                                         │
│ --silent                        Only critical errors will be printed                                                                     │
│ --version      -V               Show the version and exit.                                                                               │
│ --help                          Show this message and exit.                                                                              │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## bactopia_summary

### Tool Description
Generate a summary table from the Bactopia results.

### Metadata
- **Docker Image**: quay.io/biocontainers/bactopia:3.2.0--hdfd78af_0
- **Homepage**: https://github.com/bactopia/bactopia
- **Package**: https://anaconda.org/channels/bioconda/packages/bactopia/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bactopia/overview
- **Total Downloads**: 226.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bactopia/bactopia
- **Stars**: N/A
### Original Help Text
```text

 Usage: bactopia-summary [OPTIONS]

 Generate a summary table from the Bactopia results.

╭─ Required Options ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *  --bactopia-path  -b  TEXT  Directory where Bactopia results are stored [required]                                                     │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Gold Cutoffs ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --gold-coverage     -gcov      INTEGER  Minimum amount of coverage required for Gold status [default: 100]                               │
│ --gold-quality      -gqual     INTEGER  Minimum per-read mean quality score required for Gold status [default: 30]                       │
│ --gold-read-length  -glen      INTEGER  Minimum mean read length required for Gold status [default: 95]                                  │
│ --gold-contigs      -gcontigs  INTEGER  Maximum contig count required for Gold status [default: 100]                                     │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Silver Cutoffs ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --silver-coverage     -scov      INTEGER  Minimum amount of coverage required for Silver status [default: 50]                            │
│ --silver-quality      -squal     INTEGER  Minimum per-read mean quality score required for Silver status [default: 20]                   │
│ --silver-read-length  -slen      INTEGER  Minimum mean read length required for Silver status [default: 75]                              │
│ --silver-contigs      -scontigs  INTEGER  Maximum contig count required for Silver status [default: 200]                                 │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Fail Cutoffs ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --min-coverage        -mincov   INTEGER  Minimum amount of coverage required to pass [default: 20]                                       │
│ --min-quality         -minqual  INTEGER  Minimum per-read mean quality score required to pass [default: 12]                              │
│ --min-read-length     -minlen   INTEGER  Minimum mean read length required to pass [default: 49]                                         │
│ --max-contigs                   INTEGER  Maximum contig count required to pass [default: 500]                                            │
│ --min-assembled-size            INTEGER  Minimum assembled genome size                                                                   │
│ --max-assembled-size            INTEGER  Maximum assembled genome size                                                                   │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Additional Options ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --outdir   -o  PATH  Directory to write output [default: ./]                                                                             │
│ --prefix   -p  TEXT  Prefix to use for output files [default: bactopia]                                                                  │
│ --force              Overwrite existing reports                                                                                          │
│ --verbose            Increase the verbosity of output                                                                                    │
│ --silent             Only critical errors will be printed                                                                                │
│ --version  -V        Show the version and exit.                                                                                          │
│ --help               Show this message and exit.                                                                                         │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## bactopia_atb_formatter

### Tool Description
Restructure All-the-Bacteria assemblies to allow usage with Bactopia Tools

### Metadata
- **Docker Image**: quay.io/biocontainers/bactopia:3.2.0--hdfd78af_0
- **Homepage**: https://github.com/bactopia/bactopia
- **Package**: https://anaconda.org/channels/bioconda/packages/bactopia/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bactopia/overview
- **Total Downloads**: 226.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bactopia/bactopia
- **Stars**: N/A
### Original Help Text
```text

 Usage: bactopia-atb-formatter [OPTIONS]

 Restructure All-the-Bacteria assemblies to allow usage with Bactopia Tools

╭─ Required Options ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *  --path  -p  TEXT  Directory where ATB assemblies are stored [required]                                                                │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Bactopia Directory Structure Options ───────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --bactopia-dir  -b  TEXT            The path you would like to place bactopia structure [default: bactopia]                              │
│ --publish-mode  -m  [symlink|copy]  Specifies how assemblies will be saved in the Bactopia directory [default: symlink]                  │
│ --recursive     -r                  Traverse recursively through provided path                                                           │
│ --extension     -e  TEXT            The extension of the FASTA files [default: .fa]                                                      │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Additional Options ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --verbose        Increase the verbosity of output                                                                                        │
│ --silent         Only critical errors will be printed                                                                                    │
│ --version  -V    Show the version and exit.                                                                                              │
│ --help           Show this message and exit.                                                                                             │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## bactopia_atb_downloader

### Tool Description
Download All-the-Bacteria assemblies based on input query

### Metadata
- **Docker Image**: quay.io/biocontainers/bactopia:3.2.0--hdfd78af_0
- **Homepage**: https://github.com/bactopia/bactopia
- **Package**: https://anaconda.org/channels/bioconda/packages/bactopia/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bactopia/overview
- **Total Downloads**: 226.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bactopia/bactopia
- **Stars**: N/A
### Original Help Text
```text

 Usage: bactopia-atb-downloader [OPTIONS]

 Download All-the-Bacteria assemblies based on input query

╭─ Required Options ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *  --query  -q  TEXT  The species name, taxid, accession to query and download [required]                                                │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ ATB Download Options ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --outdir             -o  TEXT     Directory to download ATB assemblies to [default: ./atb-assemblies]                                    │
│ --atb-file-list-url  -a  TEXT     The URL to the ATB file list [default: https://osf.io/download/4yv85/]                                 │
│ --dry-run            -d           Do not download any files, just show what would be downloaded                                          │
│ --progress           -p           Show download progress bar                                                                             │
│ --cpus                   INTEGER  The total number of cpus to use for downloading and compressing                                        │
│ --uncompressed       -u           Do not compress the downloaded files                                                                   │
│ --remove-archives    -r           Remove the downloaded tar.xz archives after extracting samples                                         │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ NCBI API Options ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --ncbi-api-key  -k  TEXT     The API key to use for the NCBI API                                                                         │
│ --chunk-size    -c  INTEGER  The size of the chunks to split the list into                                                               │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Additional Options ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --force          Overwrite existing files                                                                                                │
│ --verbose        Increase the verbosity of output                                                                                        │
│ --silent         Only critical errors will be printed                                                                                    │
│ --version  -V    Show the version and exit.                                                                                              │
│ --help           Show this message and exit.                                                                                             │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## bactopia_datasets

### Tool Description
Download optional datasets to supplement your analyses with Bactopia

### Metadata
- **Docker Image**: quay.io/biocontainers/bactopia:3.2.0--hdfd78af_0
- **Homepage**: https://github.com/bactopia/bactopia
- **Package**: https://anaconda.org/channels/bioconda/packages/bactopia/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bactopia/overview
- **Total Downloads**: 226.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bactopia/bactopia
- **Stars**: N/A
### Original Help Text
```text

 Usage: bactopia-datasets [OPTIONS] [UNKNOWN]...

 Download optional datasets to supplement your analyses with Bactopia

╭─ Required Options ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *  --bactopia-path    TEXT  Directory where Bactopia repository is stored [required]                                                     │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Download Related Options ───────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --datasets_cache    TEXT     Base directory to download datasets to (Defaults to env variable BACTOPIA_CACHEDIR, a subfolder called      │
│                              datasets will be created)                                                                                   │
│                              [default: /tmp/.bactopia]                                                                                   │
│ --force                      Force overwrite of existing pre-built environments.                                                         │
│ --max_retry         INTEGER  Maximum times to attempt creating Conda environment. (Default: 3)                                           │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Additional Options ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --verbose      Print debug related text.                                                                                                 │
│ --silent       Only critical errors will be printed.                                                                                     │
│ --version      Show the version and exit.                                                                                                │
│ --help         Show this message and exit.                                                                                               │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## bactopia_pubmlst_setup

### Tool Description
One-time setup for interacting with the PubMLST API

### Metadata
- **Docker Image**: quay.io/biocontainers/bactopia:3.2.0--hdfd78af_0
- **Homepage**: https://github.com/bactopia/bactopia
- **Package**: https://anaconda.org/channels/bioconda/packages/bactopia/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bactopia/overview
- **Total Downloads**: 226.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bactopia/bactopia
- **Stars**: N/A
### Original Help Text
```text

 Usage: bactopia-pubmlst-setup [OPTIONS]

 One-time setup for interacting with the PubMLST API

╭─ Required Options ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *  --client-id      -ci  TEXT  The client ID for the site [required]                                                                     │
│ *  --client-secret  -cs  TEXT  The client secret for the site [required]                                                                 │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ API Options ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --site      -s   [pubmlst|pasteur]  Only print citation matching a given name [default: pubmlst]                                         │
│ --database  -d   TEXT               The organism database to interact with for setup. Note: the default is available from both PubMLST   │
│                                     and Pasteur                                                                                          │
│                                     [default: pubmlst_yersinia_seqdef]                                                                   │
│ --save-dir  -sd  TEXT               The directory to save the token [default: /tmp/.bactopia]                                            │
│ --force                             Force overwrite of existing token files.                                                             │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Additional Options ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --verbose        Print debug related text.                                                                                               │
│ --silent         Only critical errors will be printed.                                                                                   │
│ --version  -V    Show the version and exit.                                                                                              │
│ --help           Show this message and exit.                                                                                             │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## bactopia_pubmlst_build

### Tool Description
Build PubMLST databases for use with the 'mlst' Bactopia Tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/bactopia:3.2.0--hdfd78af_0
- **Homepage**: https://github.com/bactopia/bactopia
- **Package**: https://anaconda.org/channels/bioconda/packages/bactopia/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bactopia/overview
- **Total Downloads**: 226.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bactopia/bactopia
- **Stars**: N/A
### Original Help Text
```text

 Usage: bactopia-pubmlst-build [OPTIONS]

 Build PubMLST databases for use with the 'mlst' Bactopia Tool.

╭─ Required Options ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --database  -d  TEXT  A known organism database to download. (Use 'all' to download all databases.)                                      │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Build Options ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --ignore           TEXT  A comma separated list of databases to ignore.                                                                  │
│                          [default:                                                                                                       │
│                          afumigatus,blastocystis,calbicans,cbotulinum,cglabrata,ckrusei,ctropicalis,csinensis,kseptempunctata,rmlst,spa… │
│ --skip-download          Skip downloading the database files.                                                                            │
│ --skip-blast             Skip building the BLAST database.                                                                               │
│ --force                  Force overwrite of existing files.                                                                              │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ API Options ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --site       -s  [pubmlst|pasteur]  Only print citation matching a given name [default: pubmlst]                                         │
│ --token-dir  -t  TEXT               The directory where the token file is saved. [default: /tmp/.bactopia]                               │
│ --out-dir    -o  TEXT               The directory where the database files will be saved. [default: ./bactopia-mlst]                     │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Additional Options ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --verbose        Print debug related text.                                                                                               │
│ --silent         Only critical errors will be printed.                                                                                   │
│ --version  -V    Show the version and exit.                                                                                              │
│ --help           Show this message and exit.                                                                                             │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```


