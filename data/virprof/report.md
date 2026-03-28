# virprof CWL Generation Report

## virprof_blast-classify

### Tool Description
Compute LCA classification from BLAST search result

### Metadata
- **Docker Image**: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/seiboldlab/virprof
- **Package**: https://anaconda.org/channels/bioconda/packages/virprof/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/virprof/overview
- **Total Downloads**: 39
- **Last updated**: 2025-11-25
- **GitHub**: https://github.com/seiboldlab/virprof
- **Stars**: N/A
### Original Help Text
```text
Usage: virprof blast-classify [OPTIONS]

  Compute LCA classification from BLAST search result

Options:
  -b, --in-blast7 FILENAME  BLAST result file in format 7. May be gzipped.
                            [required]
  -o, --out FILENAME        Output CSV file containing final calls (one row
                            per bin)
  -t, --ncbi-taxonomy PATH  Path to NCBI taxonomy (tree or raw)  [required]
  -q, --quorum FLOAT        Fraction of all hits that have to be classified to
                            thereported depth. I.e., if 0.9, 90% of all input
                            blast hits for aquery must have been classified to
                            species level for a specieslevel result to be
                            reported.
  -m, --majority FLOAT      The majority required for the reported result. If
                            0.9, thedeepest path at which 90% of all hits
                            agree will be reported.
  --help                    Show this message and exit.
```


## virprof_blastbin

### Tool Description
Merge and classify contigs based on BLAST search results

### Metadata
- **Docker Image**: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/seiboldlab/virprof
- **Package**: https://anaconda.org/channels/bioconda/packages/virprof/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: virprof blastbin [OPTIONS]

  Merge and classify contigs based on BLAST search results

Options:
  -b, --in-blast7 FILENAME        BLAST result file in format 7  [required]
  -c, --in-coverage FILENAME      Samtools coverage result files
  --in-fastaqc FILENAME           VirProf FastA QC reports (entropies,
                                  homopolymers)
  -o, --out FILENAME              Output CSV file containing final calls (one
                                  row per bin)
  --out-hits, --oc FILENAME       Output CSV file containining contig details
                                  (one row per hit)  [required]
  --out-features, --of FILENAME   Output CSV file containing reference feature
                                  annotation (one row per feature)
  -t, --ncbi-taxonomy PATH        Path to NCBI taxonomy (tree or raw)
                                  [required]
  -e, --exclude TEXT              Add NCBI taxonomy scientific names to list
                                  of taxa omitted from final results. Use
                                  'None' to disable default (Hominidae)
  -i, --include TEXT              Add NCBI taxonomy scientific names to list
                                  of taxa included in final results.
  --prefilter-hits TEXT           Add NCBI taxonomy scientific names to list
                                  of taxa filtered from input BLAST search
                                  results. If within 90% bitscore of the top
                                  hit more than half the hits are removed by
                                  this filter, the entire contig is excluded.
                                  Use 'None' to disable default (various
                                  artificial, unclassified and uncultured
                                  taxonomy nodes).
  --prefilter-contigs TEXT        Add NCBI taxonomy scientific names to list
                                  of taxa filtered from input contigs as
                                  classified by relaxed LCA on input BLAST
                                  results. Use 'None' to disable default
                                  (Euteleostomi).
  -E, --no-standard-excludes      Do not exclude Human, artificial and
                                  unclassified sequences by default
  --min-read-count INTEGER        Exclude contigs with less than this number
                                  of reads. Requires --in-coverage to be set
                                  to take effect.
  --max-pcthp INTEGER             Exclude contigs with higher homopolymer
                                  percentage. Requires --in-fastaqc to be set
                                  to take effect.
  --chain-penalty INTEGER         Cost to BLAST score for concatenating two
                                  hits
  --num-words INTEGER             Number of words to add to 'words' field
  --cache-path PATH               Location for caching of remote data
  --ncbi-api-key TEXT             NCBI API Key
  --genome-size / --no-genome-size
                                  Obtain genome sizes for bins from NCBI
  --help                          Show this message and exit.
```


## virprof_download-genomes

### Tool Description
Download genomes from NCBI.

### Metadata
- **Docker Image**: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/seiboldlab/virprof
- **Package**: https://anaconda.org/channels/bioconda/packages/virprof/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: virprof download-genomes [OPTIONS]

Options:
  --species TEXT              [required]
  --outgroup [yes|no|only]
  --auto-len / --no-auto-len
  --min-len INTEGER
  --max-len INTEGER
  -t, --ncbi-taxonomy PATH    Path to NCBI taxonomy (tree or raw)  [required]
  --ncbi-api-key TEXT         NCBI API Key
  --out-accs FILENAME
  --out-fasta FILENAME
  --out-gb FILENAME
  --help                      Show this message and exit.
```


## virprof_export-fasta

### Tool Description
Exports blastbin hits in FASTA format

### Metadata
- **Docker Image**: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/seiboldlab/virprof
- **Package**: https://anaconda.org/channels/bioconda/packages/virprof/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: virprof export-fasta [OPTIONS]

  Exports blastbin hits in FASTA format

Options:
  --in-bins FILENAME              Bins CSV from blastbin command  [required]
  --in-hits FILENAME              Hits CSV from blastbin command  [required]
  --in-fasta FILENAME             FASTA file containing contigs  [required]
  --out TEXT                      FASTA output containing bins
  --out-scaffolds FILENAME        Metadata for scaffolds (CSV)
  --out-bins FILENAME             Output list of created bins
  --bin-by [sacc|species|taxname]
                                  Field to use for binning
  --fasta-id-format TEXT          Format for output FASTA header
  --file-per-bin                  Create separate file for each bin
  --filter-lineage TEXT           Filter by lineage prefix
  --scaffold / --no-scaffold      Do not merge overlapping regions
  --max-fill-length INTEGER       Break scaffolds if connecting contigs would
                                  require inserting more basepairsthan this
                                  number.
  --help                          Show this message and exit.
```


## virprof_fasta-qc

### Tool Description
Calculates contig QC values

### Metadata
- **Docker Image**: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/seiboldlab/virprof
- **Package**: https://anaconda.org/channels/bioconda/packages/virprof/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: virprof fasta-qc [OPTIONS]

  Calculates contig QC values

Options:
  -i, --in-fasta FILENAME         FASTA file containing contigs  [required]
  -o, --out-csv FILENAME          Output CSV file for scores  [required]
  --entropy-k-sizes, --ek TEXT    Lengths of k-mers to use for entropy
                                  calculation. Comma separated
  --homopolymer-min-size, --hmin INTEGER
                                  Minimum length for a repeat to be considered
                                  long homopolymer.Set to 0 to disable.
  --help                          Show this message and exit.
```


## virprof_filter-blast

### Tool Description
Filter sequences based on blast hits

### Metadata
- **Docker Image**: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/seiboldlab/virprof
- **Package**: https://anaconda.org/channels/bioconda/packages/virprof/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: virprof filter-blast [OPTIONS]

  Filter sequences based on blast hits

  Reads fasta formatted file ``in-fasta`` and removes all sequences for which
  not at least ``min-unaligned-bp`` basepairs remain uncovered by blast hits.

Options:
  --in-blast7 FILENAME        input blast7 format file  [required]
  --in-fasta FILENAME         input blast7 format file  [required]
  -o, --out FILENAME          output blast7 format file  [required]
  --min-unaligned-bp INTEGER  minimum number of unaligned basepairs
  --max-aligned-bp INTEGER    maximum number of aligned basepairs
  --help                      Show this message and exit.
```


## virprof_find-bins

### Tool Description
Collects recovered sequences into per-species files

### Metadata
- **Docker Image**: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/seiboldlab/virprof
- **Package**: https://anaconda.org/channels/bioconda/packages/virprof/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: virprof find-bins [OPTIONS]

  Collects recovered sequences into per-species files

Options:
  --in-call-files TEXT            Calls CSV from blastbin command  [required]
  --in-fasta-files TEXT           FASTA matching  [required]
  --filter-lineage TEXT           Filter by lineage prefix
  --bin-by [Sacc|Species|Taxname]
                                  Field to use for binning
  --out TEXT                      FASTA output containing bins
  --out-bins FILENAME             Output list of created bins
  --help                          Show this message and exit.
```


## virprof_index-tree

### Tool Description
Parse NCBI taxonomy from dump files and write tree to binary

### Metadata
- **Docker Image**: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/seiboldlab/virprof
- **Package**: https://anaconda.org/channels/bioconda/packages/virprof/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: virprof index-tree [OPTIONS]

  Parse NCBI taxonomy from dump files and write tree to binary

Options:
  -o, --out FILENAME              Output binary  [required]
  -b, --library [graph_tool|networkx]
                                  Tree library to use
  --ncbi-taxonomy PATH            Path to the NCBI taxonomy dump directory
                                  [required]
  --help                          Show this message and exit.
```


## virprof_init-test

### Tool Description
Set up a demo/test directory

### Metadata
- **Docker Image**: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/seiboldlab/virprof
- **Package**: https://anaconda.org/channels/bioconda/packages/virprof/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: virprof init-test [OPTIONS] PATH

  Set up a demo/test directory

Options:
  --force
  --help   Show this message and exit.
```


## virprof_prepare-phylo

### Tool Description
Prepares sequences for phylogenetic analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/seiboldlab/virprof
- **Package**: https://anaconda.org/channels/bioconda/packages/virprof/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: virprof prepare-phylo [OPTIONS] [IN_FASTA]...

  Prepares sequences for phylogenetic analysis

  Output FASTA files comprise: - Sequences from input FASTA files matching
  minimum/maximum lengths - Sequences from Genbank for given species -
  Outgroup sequences from Genbank for given species

Options:
  --species TEXT                  Species to fetch sequences for. May be
                                  specified multiple times. If given, species
                                  names will not be autodetected from input
                                  fasta file names
  --in-filter TEXT                Specify regex to filter FASTA input
                                  sequences by name
  --add-outgroup / --no-add-outgroup
                                  Not implemented  [default: no-add-outgroup]
  --add-references / --no-add-references
                                  Add reference sequences to output  [default:
                                  add-references]
  --only-references               Only export reference sequences
  --add-all-genomes / --no-add-all-genomes
                                  Add all NCBI genomes for selected species to
                                  output  [default: no-add-all-genomes]
  --include-short / --exclude-short
                                  [default: exclude-short]
  --include-full / --exclude-full
                                  [default: include-full]
  -o, --out-fasta FILENAME        Output FASTA file for alignment+treeing
                                  [required]
  --min-bp INTEGER                Minimum number of unambious base pairs.
                                  [default: 80% detected genome size]
  --min-bp INTEGER                Maximum number of unambious base pairs (for
                                  reference include only). [default: 120%
                                  detected genome size]
  --ncbi-api-key TEXT             NCBI API Key
  --help                          Show this message and exit.
```


## virprof_ymp

### Tool Description
Welcome to YMP!

### Metadata
- **Docker Image**: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/seiboldlab/virprof
- **Package**: https://anaconda.org/channels/bioconda/packages/virprof/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ymp [OPTIONS] COMMAND [ARGS]...

  Welcome to YMP!

  Please find the full manual at https://ymp.readthedocs.io

Options:
  -P, --pdb             Drop into debugger on uncaught exception
  -q, --quiet           Decrease log verbosity
  -v, --verbose         Increase log verbosity
  --log-file TEXT       Specify a log file
  --version             Show the version and exit.
  --install-completion  Install command completion for the current shell. Make
                        sure to have psutil installed.
  --profile FILENAME    Profile execution time using Yappi
  -h, --help            Show this message and exit.

Commands:
  env     Manipulate conda software environments
  init    Initialize YMP workspace
  make    Build target(s) locally
  scan
  show    Show configuration properties
  stage   Manipulate YMP stages
  submit  Build target(s) on cluster
```


## Metadata
- **Skill**: generated
