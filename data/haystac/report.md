# haystac CWL Generation Report

## haystac_config

### Tool Description
Configuration options

### Metadata
- **Docker Image**: quay.io/biocontainers/haystac:0.4.12--pyhcf36b3e_0
- **Homepage**: https://github.com/antonisdim/haystac
- **Package**: https://anaconda.org/channels/bioconda/packages/haystac/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/haystac/overview
- **Total Downloads**: 22.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/antonisdim/haystac
- **Stars**: N/A
### Original Help Text
```text
usage: haystac config [-h] [-v] [--cache <path>] [--clear-cache]
                      [--api-key <code>] [--use-conda <bool>]

Configuration options

Optional arguments:
  -h, --help          Show this help message and exit
  -v, --version       Print the version number and exit
  --cache <path>      Cache folder for storing genomes downloaded from NCBI
                      and other shared data (default: /root/haystac/cache)
  --clear-cache       Clear the contents of the cache folder, and delete the
                      folder itself (default: False)
  --api-key <code>    Personal NCBI API key (increases max concurrent requests
                      from 3 to 10,
                      https://www.ncbi.nlm.nih.gov/account/register/)
  --use-conda <bool>  Use conda as a package manger (default: True)
```


## haystac_database

### Tool Description
Build a database of target species

### Metadata
- **Docker Image**: quay.io/biocontainers/haystac:0.4.12--pyhcf36b3e_0
- **Homepage**: https://github.com/antonisdim/haystac
- **Package**: https://anaconda.org/channels/bioconda/packages/haystac/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haystac database --mode <mode> --output <path> [--query <query>]
                        [--query-file <path>] [--accessions-file <path>]
                        [--sequences-file <path>] [--refseq-rep <table>]
                        [--force-accessions]
                        [--exclude-accessions <accession> [<accession> ...]]
                        [--resolve-accessions] [--bowtie2-scaling <float>]
                        [--bowtie2-threads <int>] [--rank <rank>]
                        [--genera <genus> [<genus> ...]] [--mtDNA]
                        [--seed <int>] [--batch <str>] [-h] [-v]
                        [--cores <int>] [--mem <int>] [--unlock] [--debug]
                        [--snakemake '<json>']

Build a database of target species

Required arguments:
  --mode <mode>         Database creation mode for haystac [fetch, index,
                        build]
  --output <path>       Path to the database output directory

Required choice:
  --query <query>       Database query in the NCBI query language. Please
                        refer to the documentation for assistance with
                        constructing a valid query.
  --query-file <path>   File containing a database query in the NCBI query
                        language.
  --accessions-file <path>
                        Tab delimited file containing one record per row: the
                        name of the taxon, and a valid NCBI accession code
                        from the nucleotide, assembly or WGS databases.
  --sequences-file <path>
                        Tab delimited file containing one record per row: the
                        name of the taxon, a user defined accession code, and
                        the path to the fasta file (optionally compressed).
  --refseq-rep <table>  Use one of the RefSeq curated tables to construct a
                        DB. Includes all prokaryotic species (excluding
                        strains) from the representative RefSeq DB, or all the
                        species and strains from the viruses DB, or all the
                        species and subspecies from the eukaryotes DB. If
                        multiple accessions exist for a given species/strain,
                        the first pair of species/accession is kept. Available
                        RefSeq tables to use [prokaryote_rep, viruses,
                        eukaryotes].

Optional arguments:
  --force-accessions    Disable validation checks for 'anomalous' assembly
                        flags in NCBI (default: False)
  --exclude-accessions <accession> [<accession> ...]
                        List of NCBI accessions to exclude. (default: [])
  --resolve-accessions  Pick the first accession when two accessions for a
                        taxon can be found in user provided input files
                        (default: False)
  --bowtie2-scaling <float>
                        Rescaling factor to keep the bowtie2 mutlifasta index
                        below the maximum memory limit (default: 25.0)
  --bowtie2-threads <int>
                        Number of threads bowtie2 will use to index every
                        individual genome in the database (default: 4)
  --rank <rank>         Taxonomic rank to perform the identifications on
                        [genus, species, subspecies, serotype] (default:
                        species)
  --genera <genus> [<genus> ...]
                        List of genera to restrict the abundance calculations.
  --mtDNA               For eukaryotes, download mitochondrial genomes only.
                        Not to be used with --refseq-rep or queries containing
                        prokaryotes (default: False)
  --seed <int>          Random seed for database indexing
  --batch <str>         Batch number for large`haystac database` workflows
                        (e.g. --batch index_all_accessions=1/3). You will need
                        to execute all batches before haystac is able to
                        finish its workflow to the end.

Common arguments:
  -h, --help            Show this help message and exit
  -v, --version         Print the version number and exit
  --cores <int>         Maximum number of CPU cores to use (default: 20)
  --mem <int>           Maximum memory (MB) to use (default: 63985)
  --unlock              Unlock the output directory following a crash or hard
                        restart (default: False)
  --debug               Enable debugging mode (default: False)
  --snakemake '<json>'  Pass additional flags to the `snakemake` scheduler.
```


## haystac_sample

### Tool Description
Prepare a sample for analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/haystac:0.4.12--pyhcf36b3e_0
- **Homepage**: https://github.com/antonisdim/haystac
- **Package**: https://anaconda.org/channels/bioconda/packages/haystac/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haystac sample --output <path> [--fastq <path>] [--fastq-r1 <path>]
                      [--fastq-r2 <path>] [--sra <accession>]
                      [--collapse <bool>] [--trim-adapters <bool>] [-h] [-v]
                      [--cores <int>] [--mem <int>] [--unlock] [--debug]
                      [--snakemake '<json>']

Prepare a sample for analysis

Required arguments:
  --output <path>       Path to the sample output directory

Required choice:
  --fastq <path>        Single-end fastq input file (optionally compressed).
  --fastq-r1 <path>     Paired-end forward strand (R1) fastq input file.
  --fastq-r2 <path>     Paired-end reverse strand (R2) fastq input file.
  --sra <accession>     Download fastq input from the SRA database

Optional arguments:
  --collapse <bool>     Collapse overlapping paired-end reads, e.g. for aDNA
                        (default: False)
  --trim-adapters <bool>
                        Automatically trim sequencing adapters from fastq
                        input (default: True)

Common arguments:
  -h, --help            Show this help message and exit
  -v, --version         Print the version number and exit
  --cores <int>         Maximum number of CPU cores to use (default: 20)
  --mem <int>           Maximum memory (MB) to use (default: 63985)
  --unlock              Unlock the output directory following a crash or hard
                        restart (default: False)
  --debug               Enable debugging mode (default: False)
  --snakemake '<json>'  Pass additional flags to the `snakemake` scheduler.
```


## haystac_analyse

### Tool Description
Analyse a sample against a database

### Metadata
- **Docker Image**: quay.io/biocontainers/haystac:0.4.12--pyhcf36b3e_0
- **Homepage**: https://github.com/antonisdim/haystac
- **Package**: https://anaconda.org/channels/bioconda/packages/haystac/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haystac analyse --mode <mode> --database <path> --sample <path>
                       --output <path> [--genera <genus> [<genus> ...]]
                       [--min-prob <float>] [--mismatch-probability <float>]
                       [--bowtie2-threads <int>] [--batch <str>]
                       [--mapdamage <bool>] [--aDNA] [-h] [-v] [--cores <int>]
                       [--mem <int>] [--unlock] [--debug]
                       [--snakemake '<json>']

Analyse a sample against a database

Required arguments:
  --mode <mode>         Analysis mode for the selected sample [filter, align,
                        likelihoods, probabilities, abundances, reads]
  --database <path>     Path to the database output directory
  --sample <path>       Path to the sample output directory
  --output <path>       Path to the analysis output directory

Optional arguments:
  --genera <genus> [<genus> ...]
                        List of genera to restrict the abundance calculations
                        (default: [])
  --min-prob <float>    Minimum posterior probability to assign an aligned
                        read to a given species (default: 0.75)
  --mismatch-probability <float>
                        Base mismatch probability (default: 0.05)
  --bowtie2-threads <int>
                        Number of threads bowtie2 will use to align a sample
                        against every individual genome in the database
                        (default: 4)
  --batch <str>         Batch number for large`haystac analyse` workflows
                        (e.g. --batch align_all_accessions=1/3). You will need
                        to execute all batches before haystac is able to
                        finish its workflow to the end.
  --mapdamage <bool>    Perform mapdamage analysis for ancient samples
                        (default: False)
  --aDNA                Set new flag defaults for aDNA sample analysis:
                        mismatch-probability=0.20, min-prob=0.5,
                        mapdamage=True (default: False)

Common arguments:
  -h, --help            Show this help message and exit
  -v, --version         Print the version number and exit
  --cores <int>         Maximum number of CPU cores to use (default: 20)
  --mem <int>           Maximum memory (MB) to use (default: 63985)
  --unlock              Unlock the output directory following a crash or hard
                        restart (default: False)
  --debug               Enable debugging mode (default: False)
  --snakemake '<json>'  Pass additional flags to the `snakemake` scheduler.
```


## haystac_Command

### Tool Description
The haystac commands are:

### Metadata
- **Docker Image**: quay.io/biocontainers/haystac:0.4.12--pyhcf36b3e_0
- **Homepage**: https://github.com/antonisdim/haystac
- **Package**: https://anaconda.org/channels/bioconda/packages/haystac/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haystac <command> [<args>]

The haystac commands are:
   config         Configuration options
   database       Build a database of target species
   sample         Prepare a sample for analysis
   analyse        Analyse a sample against a database
   
haystac: error: argument command: invalid choice: 'Command' (choose from 'config', 'database', 'sample', 'analyse')
```


## Metadata
- **Skill**: generated
