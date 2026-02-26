# recognizer CWL Generation Report

## recognizer

### Tool Description
a tool for domain based annotation with the CDD database

### Metadata
- **Docker Image**: quay.io/biocontainers/recognizer:1.11.1--hdfd78af_0
- **Homepage**: https://github.com/iquasere/reCOGnizer
- **Package**: https://anaconda.org/channels/bioconda/packages/recognizer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/recognizer/overview
- **Total Downloads**: 110.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/iquasere/reCOGnizer
- **Stars**: N/A
### Original Help Text
```text
usage: recognizer [-h] [-f FILE] [-t THREADS] [--evalue EVALUE] [-o OUTPUT]
                  [-rd RESOURCES_DIRECTORY] [-dbs DATABASES]
                  [--custom-databases] [-mts MAX_TARGET_SEQS] [--keep-spaces]
                  [--no-output-sequences] [--no-blast-info]
                  [--output-rpsbproc-cols] [--keep-intermediates] [--quiet]
                  [--debug] [--test-run] [-v] [--tax-file TAX_FILE]
                  [--protein-id-col PROTEIN_ID_COL] [--tax-col TAX_COL]
                  [--species-taxids]

reCOGnizer - a tool for domain based annotation with the CDD database

options:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  Fasta file with protein sequences for annotation
  -t THREADS, --threads THREADS
                        Number of threads for reCOGnizer to use [max
                        available]
  --evalue EVALUE       Maximum e-value to report annotations for [1e-3]
  -o OUTPUT, --output OUTPUT
                        Output directory [reCOGnizer_results]
  -rd RESOURCES_DIRECTORY, --resources-directory RESOURCES_DIRECTORY
                        Output directory for storing databases and other
                        resources [~/recognizer_resources]
  -dbs DATABASES, --databases DATABASES
                        Databases to include in functional annotation (comma-
                        separated) [NCBI_Curated,Pfam,SMART,KOG,COG,PRK,TIGR]
  --custom-databases    If databases inputted were NOT produced by reCOGnizer
                        [False]. Default databases of reCOGnizer (e.g., COG,
                        TIGR, ...) can't be used simultaneously with custom
                        databases. Use together with the '--databases'
                        parameter.
  -mts MAX_TARGET_SEQS, --max-target-seqs MAX_TARGET_SEQS
                        Number of maximum identifications for each protein [1]
  --keep-spaces         BLAST ignores sequences IDs after the first space.
                        This option changes all spaces to underscores to keep
                        the full IDs.
  --no-output-sequences
                        Protein sequences from the FASTA input will be stored
                        in their own column.
  --no-blast-info       Information from the alignment will be stored in their
                        own columns.
  --output-rpsbproc-cols
                        Output columns obtained with RPSBPROC -
                        'Superfamilies', 'Sites' and 'Motifs'.
  --keep-intermediates  Keep intermediate annotation files generated in
                        reCOGnizer's workflow, i.e., ASN, RPSBPROC and BLAST
                        reports and split FASTA inputs.
  --quiet               Don't output download information, used mainly for CI.
  --debug               Print all commands running in the background,
                        including those of rpsblast and rpsbproc.
  --test-run            This parameter is only appropriate for reCOGnizer's
                        tests on GitHub. Should not be used.
  -v, --version         show program's version number and exit

Taxonomy Arguments:
  --tax-file TAX_FILE   File with taxonomic identification of proteins
                        inputted (TSV). Must have one line per query, query
                        name on first column, taxid on second.
  --protein-id-col PROTEIN_ID_COL
                        Name of column with protein headers as in supplied
                        FASTA file [qseqid]
  --tax-col TAX_COL     Name of column with tax IDs of proteins [Taxonomic
                        identifier (SPECIES)]
  --species-taxids      If tax col contains Tax IDs of species (required for
                        running COG taxonomic)

Input file must be specified.
```

