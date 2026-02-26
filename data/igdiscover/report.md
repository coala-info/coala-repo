# igdiscover CWL Generation Report

## igdiscover_augment

### Tool Description
Augment AIRR-formatted IgBLAST output with extra IgDiscover-specific columns

Also, fill in the CDR3 columns

### Metadata
- **Docker Image**: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
- **Homepage**: https://igdiscover.se/
- **Package**: https://anaconda.org/channels/bioconda/packages/igdiscover/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/igdiscover/overview
- **Total Downloads**: 77.1K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: igdiscover augment [-h] [--sequence-type {Ig,TCR}] [--rename PREFIX]
                          [--stats FILE]
                          database table

Augment AIRR-formatted IgBLAST output with extra IgDiscover-specific columns

Also, fill in the CDR3 columns

positional arguments:
  database              Database directory with V.fasta, D.fasta, J.fasta.
  table                 AIRR rearrangement table

options:
  -h, --help            show this help message and exit
  --sequence-type {Ig,TCR}
                        Sequence type. Default: Ig
  --rename PREFIX       Rename reads to PREFIXseqN (where N is a number
                        starting at 1)
  --stats FILE          Write statistics in JSON format to FILE
igdiscover augment: error: the following arguments are required: database, table
```


## igdiscover_clonoquery

### Tool Description
Query a table of assigned sequences by clonotype

### Metadata
- **Docker Image**: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
- **Homepage**: https://igdiscover.se/
- **Package**: https://anaconda.org/channels/bioconda/packages/igdiscover/overview
- **Validation**: PASS

### Original Help Text
```text
usage: igdiscover clonoquery [-h] [--minimum-count N] [--cdr3-core START:END]
                             [--mismatches MISMATCHES] [--aa] [--summary FILE]
                             reftable querytable

Query a table of assigned sequences by clonotype

Two sequences have the same clonotype if
- their V and J assignments are the same
- the length of their CDR3 is identical
- the difference between their CDR3s (in terms of mismatches)
  is not higher than a given threshold (by default 1)

Clonotypes for the query sequences are determined and sequences
in the input table that have this clonotype are reported.

The table is written to standard output.

positional arguments:
  reftable              Reference table with parsed and filtered IgBLAST
                        results (filtered.tab)
  querytable            Query table with IgBLAST results (assigned.tab or
                        filtered.tab)

options:
  -h, --help            show this help message and exit
  --minimum-count N, -c N
                        Discard all rows with count less than N. Default: 1
  --cdr3-core START:END
                        START:END defines the non-junction region of CDR3
                        sequences. Use negative numbers for END to count from
                        the end. Regions before and after are considered to be
                        junction sequence, and for two CDR3s to be considered
                        similar, at least one of the junctions must be
                        identical. Default: no junction region.
  --mismatches MISMATCHES
                        No. of allowed mismatches between CDR3 sequences. Can
                        also be a fraction between 0 and 1 (such as 0.15),
                        interpreted relative to the length of the CDR3 (minus
                        the front non-core). Default: 1
  --aa                  Count CDR3 mismatches on amino-acid level. Default:
                        Compare nucleotides.
  --summary FILE        Write summary table to FILE
igdiscover clonoquery: error: the following arguments are required: reftable, querytable
```


## igdiscover_clonotypes

### Tool Description
Group assigned sequences by clonotype

### Metadata
- **Docker Image**: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
- **Homepage**: https://igdiscover.se/
- **Package**: https://anaconda.org/channels/bioconda/packages/igdiscover/overview
- **Validation**: PASS

### Original Help Text
```text
usage: igdiscover clonotypes [-h] [--sort] [--limit N]
                             [--v-shm-threshold V_SHM_THRESHOLD]
                             [--cdr3-core START:END] [--mismatches MISMATCHES]
                             [--aa] [--no-mindiffrate] [--members FILE]
                             table

Group assigned sequences by clonotype

Two sequences have the same clonotype if
- their V and J assignments are the same
- the length of their CDR3 is identical
- the difference between their CDR3s (in terms of mismatches)
  is not higher than a given threshold (by default 1)

The output is a table with one row per clonotype, written to
standard output.

Optionally, a full table of all members (sequences belonging to a clonotype)
can be created with one row per input sequence, sorted by
clonotype, plus an empty line between each group of sequences
that have the same clonotype.

The tables are by default sorted by clonotype, but can instead be sorted
by the group size (number of members of a clonotype).

positional arguments:
  table                 Table with parsed and filtered IgBLAST results

options:
  -h, --help            show this help message and exit
  --sort                Sort by group size (largest first). Default: Sort by
                        V/D/J gene names
  --limit N             Print out only the first N groups
  --v-shm-threshold V_SHM_THRESHOLD
                        V SHM threshold for _mindiffrate computations
  --cdr3-core START:END
                        START:END defines the non-junction region of CDR3
                        sequences. Use negative numbers for END to count from
                        the end. Regions before and after are considered to be
                        junction sequence, and for two CDR3s to be considered
                        similar, at least one of the junctions must be
                        identical. Default: no junction region.
  --mismatches MISMATCHES
                        No. of allowed mismatches between CDR3 sequences. Can
                        also be a fraction between 0 and 1 (such as 0.15),
                        interpreted relative to the length of the CDR3 (minus
                        the front non-core). Default: 1
  --aa                  Count CDR3 mismatches on amino-acid level. Default:
                        Compare nucleotides.
  --no-mindiffrate      Do not add _mindiffrate columns
  --members FILE        Write member table to FILE
igdiscover clonotypes: error: argument -h/--help: ignored explicit argument 'elp'
```


## igdiscover_clusterplot

### Tool Description
Plot a clustermap of all sequences assigned to a gene

### Metadata
- **Docker Image**: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
- **Homepage**: https://igdiscover.se/
- **Package**: https://anaconda.org/channels/bioconda/packages/igdiscover/overview
- **Validation**: PASS

### Original Help Text
```text
usage: igdiscover clusterplot [-h] [--minimum-group-size N] [--gene GENE]
                              [--type {V,D,J}] [--size N] [--ignore-J]
                              [--dpi DPI] [--no-title]
                              table directory

Plot a clustermap of all sequences assigned to a gene

positional arguments:
  table                 Table with parsed and filtered IgBLAST results
  directory             Save clustermaps as PNG into this directory

options:
  -h, --help            show this help message and exit
  --minimum-group-size N, -m N
                        Do not plot if there are less than N sequences for a
                        gene. Default: 200
  --gene GENE, -g GENE  Plot GENE. Can be given multiple times. Default: Plot
                        all genes.
  --type {V,D,J}        Gene type. Default: V
  --size N              Show at most N sequences (with a matrix of size N x
                        N). Default: 300
  --ignore-J            Include also rows without J assignment or J%SHM>0.
  --dpi DPI             Resolution of output file. Default: 200
  --no-title            Do not add a title to the plot
igdiscover clusterplot: error: the following arguments are required: table, directory
```


## igdiscover_commonv

### Tool Description
Find common V genes between two different antibody libraries.

### Metadata
- **Docker Image**: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
- **Homepage**: https://igdiscover.se/
- **Package**: https://anaconda.org/channels/bioconda/packages/igdiscover/overview
- **Validation**: PASS

### Original Help Text
```text
usage: igdiscover commonv [-h] [--minimum-frequency N] table [table ...]

Find common V genes between two different antibody libraries.

positional arguments:
  table                 Tables with parsed and filtered IgBLAST results (give
                        at least two)

options:
  -h, --help            show this help message and exit
  --minimum-frequency N, -n N
                        Minimum number of datasets in which sequence must
                        occur (default is no. of files divided by two)
igdiscover commonv: error: argument -h/--help: ignored explicit argument 'elp'
```


## igdiscover_config

### Tool Description
Configure igdiscover

### Metadata
- **Docker Image**: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
- **Homepage**: https://igdiscover.se/
- **Package**: https://anaconda.org/channels/bioconda/packages/igdiscover/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/igdiscover", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.10/site-packages/igdiscover/__main__.py", line 92, in main
    to_run()
  File "/usr/local/lib/python3.10/site-packages/igdiscover/__main__.py", line 90, in <lambda>
    to_run = lambda: module.main(args)
  File "/usr/local/lib/python3.10/site-packages/igdiscover/cli/config.py", line 34, in main
    print_configuration(args.file)
  File "/usr/local/lib/python3.10/site-packages/igdiscover/cli/config.py", line 64, in print_configuration
    with open(path) as f:
FileNotFoundError: [Errno 2] No such file or directory: 'igdiscover.yaml'
```


## igdiscover_count

### Tool Description
Compute expression counts

### Metadata
- **Docker Image**: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
- **Homepage**: https://igdiscover.se/
- **Package**: https://anaconda.org/channels/bioconda/packages/igdiscover/overview
- **Validation**: PASS

### Original Help Text
```text
usage: igdiscover count [-h] [--gene {V,D,J}] [--database FASTA] [--plot FILE]
                        [--d-evalue D_EVALUE] [--d-coverage D_COVERAGE]
                        [--d-errors D_ERRORS] [--allele-ratio RATIO]
                        table

Compute expression counts

This command takes a table of filtered IgBLAST results (filtered.tab.gz),
filters it by various criteria and then counts how often specific
genes are named.

By default, all genes with non-zero expression are listed, sorted by
name. Use --database to change this.

positional arguments:
  table                 Table with parsed and filtered IgBLAST results

options:
  -h, --help            show this help message and exit
  --gene {V,D,J}        Which gene type: Choose V, D or J. Default: Default: V
  --database FASTA      Compute expressions for the sequences that are named
                        in the FASTA file. Only the sequence names in the file
                        are used! This is the only way to also include genes
                        with an expression of zero.
  --plot FILE           Plot expressions to FILE (PDF or PNG)

Input table filtering:
  --d-evalue D_EVALUE   Maximal allowed E-value for D gene match. Default:
                        1E-4 if --gene=D, no restriction otherwise.
  --d-coverage D_COVERAGE, --D-coverage D_COVERAGE
                        Minimum D coverage (in percent). Default: 70 if
                        --gene=D, no restriction otherwise.
  --d-errors D_ERRORS   Maximum allowed D errors. Default: No limit.

Expression counts table filtering:
  --allele-ratio RATIO  Required allele ratio. Works only for genes named
                        "NAME*ALLELE". Default: Do not check allele ratio.
igdiscover count: error: argument -h/--help: ignored explicit argument 'elp'
```


## igdiscover_dbdiff

### Tool Description
Compare two FASTA files based on sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
- **Homepage**: https://igdiscover.se/
- **Package**: https://anaconda.org/channels/bioconda/packages/igdiscover/overview
- **Validation**: PASS

### Original Help Text
```text
usage: igdiscover dbdiff [-h] [--color {auto,never,always}] a b

Compare two FASTA files based on sequences

The order of records in the two files does not matter.

Exit code:
    2 if duplicate sequences or duplicate record names were found
    1 if there are any lost or gained records or sequence differences
    0 if the records are identical, but allowing for different record names

positional arguments:
  a                     FASTA file with expected sequences
  b                     FASTA file with actual sequences

options:
  -h, --help            show this help message and exit
  --color {auto,never,always}
                        Whether to colorize output
igdiscover dbdiff: error: argument -h/--help: ignored explicit argument 'elp'
```

