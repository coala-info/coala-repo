# seqforge CWL Generation Report

## seqforge_makedb

### Tool Description
Create a BLAST database from a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqforge:2.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/ERBringHorvath/SeqForge
- **Package**: https://anaconda.org/channels/bioconda/packages/seqforge/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seqforge/overview
- **Total Downloads**: 310
- **Last updated**: 2025-10-01
- **GitHub**: https://github.com/ERBringHorvath/SeqForge
- **Stars**: N/A
### Original Help Text
```text
usage: seqforge makedb [-h] -f FASTA_DIRECTORY -o OUTPUT_DIR [-T THREADS] [-s]
                       [--temp-dir TEMP_DIR] [--keep-temp-files]
                       [-p [{none,bar,verbose}]]

Create a BLAST database from a FASTA file.

options:
  -h, --help            show this help message and exit
  -f, --fasta-directory FASTA_DIRECTORY
                        Path to FASTA files.
  -o, --output-dir OUTPUT_DIR
                        Name for the output database.
  -T, --threads THREADS
                        Number of cores to dedicate for multi-processing
  -s, --sanitize        Permanently remove special characters from FASTA file(s)
  --temp-dir TEMP_DIR   Specify temporary directory (default = /tmp/)
  --keep-temp-files     Keep extracted temporary files for debugging
  -p, --progress [{none,bar,verbose}]
                        Progress reporting mode passing only --progress is equivalent to --progress bar 'verbose' prints a line per item, 'none' silences output
```


## seqforge_query

### Tool Description
Run BLAST queries in parallel.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqforge:2.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/ERBringHorvath/SeqForge
- **Package**: https://anaconda.org/channels/bioconda/packages/seqforge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqforge query [-h] -d DATABASE -q QUERY_FILES [-T THREADS] [-e EVALUE]
                      -o OUTPUT_DIR [--min-perc MIN_PERC] [--min-cov MIN_COV]
                      [-R] [-N] [--min-seq-len MIN_SEQ_LEN] [-a]
                      [--temp-dir TEMP_DIR] [--keep-temp-files]
                      [--motif MOTIF [MOTIF ...]] [--motif-fasta-out]
                      [--motif-only] [-f FASTA_DIRECTORY] [-V] [-P]
                      [-p [{bar,verbose,none}]]

Run BLAST queries in parallel.

options:
  -h, --help            show this help message and exit
  -d, --database DATABASE
                        Path to the BLAST databases.
  -q, --query-files QUERY_FILES
                        Path to the query files in FASTA format.
  -T, --threads THREADS
                        Number of cores to dedicate
  -e, --evalue EVALUE   E-value threshold.
  -o, --output-dir OUTPUT_DIR
                        Path to directory to store results.
  --min-perc MIN_PERC   Define percent identity threshold (default = 90)
  --min-cov MIN_COV     Define query coverage threshold (default = 75)
  -R, --report-strongest-matches
                        Report only the top hit for each query
  -N, --nucleotide-query
                        Use blastn for nucelotide queries
  --min-seq-len MIN_SEQ_LEN
                        Minimum sequence length for database searches (use with caution)
  -a, --no-alignment-files
                        Do not generate BLAST alignment output files.
  --temp-dir TEMP_DIR   Specify a temporary directory (default = /tmp/)
  --keep-temp-files     Keep temporary *_results.txt files in the output directory
  --motif MOTIF [MOTIF ...]
                        Amino acid motif (e.g., GHXXGE) to search within blast hits. X is treated as a wildcard. 
                        For use only with blastp queries Motifs may be linked to specific query results using braces. For example: 'query_file.faa' --> '--motif GHXXGE{query_file}'
  --motif-fasta-out     Export motif match source gene as FASTA file(s)
  --motif-only          For use with --motif-fasta-out, output only the motif string
  -f, --fasta-directory FASTA_DIRECTORY
                        Path to FASTA file or directory of FASTA files used to create the BLAST databases. Required if using --motif
  -V, --visualize       visualize query results
  -P, --pdf             Output figure to PDF instead of PNG
  -p, --progress [{bar,verbose,none}]
                        Progress reporting mode passing only --progress is equivalent to --progress bar 'verbose' prints a line per item, 'none' silences output
```


## seqforge_split-fasta

### Tool Description
Split a multi-FASTA into per-record files or fixed-size fragments.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqforge:2.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/ERBringHorvath/SeqForge
- **Package**: https://anaconda.org/channels/bioconda/packages/seqforge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqforge split-fasta [-h] -f FASTA -o OUTPUT_DIR [-F FRAGMENT] [-C]

Split a multi-FASTA into per-record files or fixed-size fragments.

options:
  -h, --help            show this help message and exit
  -f, --fasta FASTA     Input multi-FASTA file
  -o, --output-dir OUTPUT_DIR
                        Output directory for split FASTA files
  -F, --fragment FRAGMENT
                        Split multi-FASTA into chunks of this many sequences
  -C, --compress        Compress output files as .gz
```


## seqforge_extract

### Tool Description
Extract sequences based on SeqForge Query results.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqforge:2.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/ERBringHorvath/SeqForge
- **Package**: https://anaconda.org/channels/bioconda/packages/seqforge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqforge extract [-h] -c CSV_PATH -f FASTA_DIRECTORY -o OUTPUT_FASTA
                        [-T THREADS] [-e EVALUE] [--min-perc MIN_PERC]
                        [--min-cov MIN_COV] [--translate] [--up UP]
                        [--down DOWN] [--temp-dir TEMP_DIR]
                        [--keep-temp-files]

Extract sequences based on SeqForge Query results.

options:
  -h, --help            show this help message and exit
  -c, --csv-path CSV_PATH
                        Path to BLAST results files.
  -f, --fasta-directory FASTA_DIRECTORY
                        Path to reference FASTA assemblies.
  -o, --output-fasta OUTPUT_FASTA
                        Output FASTA file name.
  -T, --threads THREADS
                        Number of cores to dedicate.
  -e, --evalue EVALUE   Minimum e-value threshold for sequence extraction.
  --min-perc MIN_PERC   Minimum percent identity threshold for sequence extraction.
  --min-cov MIN_COV     Minimum query coverage threshold for sequence extraction.
  --translate           Translate extracted nucleotide sequence using the standard genetic code.
  --up UP               Extract additional basepairs upstream of aligned sequence
  --down DOWN           Extract additional basepairs downstream of aligned sequence
  --temp-dir TEMP_DIR   Specify a temporary directory (default = /tmp/)
  --keep-temp-files     Keep extracted temporary files for debugging (only with archive submission)
```


## seqforge_extract-contig

### Tool Description
Extract entire contigs containing matching sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqforge:2.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/ERBringHorvath/SeqForge
- **Package**: https://anaconda.org/channels/bioconda/packages/seqforge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqforge extract-contig [-h] -c CSV_PATH -f FASTA_DIRECTORY
                               -o OUTPUT_FASTA [-T THREADS] [-e EVALUE]
                               [--min-perc MIN_PERC] [--min-cov MIN_COV]
                               [--temp-dir TEMP_DIR] [--keep-temp-files]

Extract entire contigs containing matching sequences.

options:
  -h, --help            show this help message and exit
  -c, --csv-path CSV_PATH
                        Path to Query results file (all_results.csv or all_filtered_results.csv)
  -f, --fasta-directory FASTA_DIRECTORY
                        Path to your FASTA files used to create 'makedb' databases
  -o, --output-fasta OUTPUT_FASTA
                        Output FASTA file with extension (.fa, .fas, .fna, .fasta)
  -T, --threads THREADS
                        Number of cores to dedicate
  -e, --evalue EVALUE   Minimum e-value threshold
  --min-perc MIN_PERC   Minimum percent identity threshold
  --min-cov MIN_COV     Minimum query coverage threshold
  --temp-dir TEMP_DIR   Specify a temporary directory (default = /tmp/)
  --keep-temp-files     Keep extracted temporary files for debugging (only with archive submission)
```


## seqforge_search

### Tool Description
Extract metadata from GenBank or JSON files.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqforge:2.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/ERBringHorvath/SeqForge
- **Package**: https://anaconda.org/channels/bioconda/packages/seqforge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqforge search [-h] -i INPUT -o OUTPUT [--all]
                       [--fields FIELD [FIELD ...]] [--json] [--gb]

Extract metadata from GenBank or JSON files.

options:
  -h, --help            show this help message and exit
  -i, --input INPUT     Input file (.json or .gb/.gbk/.genbank)
  -o, --output OUTPUT   Output file (e.g., .csv, .tsv, .json)
  --all                 Extract all available metadata
  --fields FIELD [FIELD ...]
                        Space-separated list of metadata fields to extract. Allowed fields: accession, organism, strain, isolation_source, host, region, lat_lon, collection_date, collected_by, tax_id, comment, keywords, sequencing_tech, release_date
  --json                Parse only JSON files in the input directory
  --gb                  Parse only GenBank files in the input directory
```


## seqforge_sanitize

### Tool Description
Remove special characters from input file names (content unchanged; needed for BLAST+).

### Metadata
- **Docker Image**: quay.io/biocontainers/seqforge:2.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/ERBringHorvath/SeqForge
- **Package**: https://anaconda.org/channels/bioconda/packages/seqforge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqforge sanitize [-h] -i INPUT [-e EXTENSION [EXTENSION ...]] [-I]
                         [-S OUTPUT] [--dry-run]

Remove special characters from input file names (content unchanged; needed for BLAST+).

options:
  -h, --help            show this help message and exit
  -i, --input INPUT     File(s) to sanitize. Can be a single file or a directory of files
  -e, --extension EXTENSION [EXTENSION ...]
                        File extensions to process. Not needed if submitting a single file. For FASTA files, run '-e fasta' to allow for all standard FASTA extensions
  -I, --in-place        Rename files in place (recommended)
  -S, --sanitize-outdir OUTPUT
                        Leave original filenames unchanged, but copy them to a new directory with santitized filenames
  --dry-run             Preview changes without renaming any files
```


## seqforge_fasta-metrics

### Tool Description
Compute FASTA statistics (e.g., N50, GC content).

### Metadata
- **Docker Image**: quay.io/biocontainers/seqforge:2.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/ERBringHorvath/SeqForge
- **Package**: https://anaconda.org/channels/bioconda/packages/seqforge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqforge fasta-metrics [-h] -f FASTA_DIRECTORY [-o OUTPUT]
                              [-M MIN_CONTIG_SIZE] [--temp-dir TEMP_DIR]
                              [--keep-temp-files]

Compute FASTA statistics (e.g., N50, GC content).

options:
  -h, --help            show this help message and exit
  -f, --fasta-directory FASTA_DIRECTORY
                        Path to FASTA file or directory of FASTA files
  -o, --output OUTPUT   Optional name for CSV summary (default: fasta_metrics_summary.csv)
  -M, --min-contig-size MIN_CONTIG_SIZE
                        Minimum contig size (in bp) to include for calculation of all reported metrics (default = 500)
  --temp-dir TEMP_DIR   Specify a temporary directory (default = /tmp/)
  --keep-temp-files     Keep extracted temporary files for debugging (only with archive submission)
```


## seqforge_unique-headers

### Tool Description
Append source and a unique suffix to FASTA headers (supports --deterministic).

### Metadata
- **Docker Image**: quay.io/biocontainers/seqforge:2.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/ERBringHorvath/SeqForge
- **Package**: https://anaconda.org/channels/bioconda/packages/seqforge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqforge unique-headers [-h] -f FASTA_DIRECTORY [-o OUTPUT_DIR] [-I]
                               [-p [{bar,verbose,none}]] [-D]

Append source and a unique suffix to FASTA headers (supports --deterministic).

options:
  -h, --help            show this help message and exit
  -f, --fasta-directory FASTA_DIRECTORY
                        Path to FASTA file(s)
  -o, --output-dir OUTPUT_DIR
                        Directory for output FASTA files (unless using --in-place)
  -I, --in-place        Modify input files in-place (uses temporary files for safety)
  -p, --progress [{bar,verbose,none}]
                        Progress reporting mode; passing only --progress is equivalent to --progress bar '--verbose' prints a line per record, 'none' silences output
  -D, --deterministic   Use a stable MD5-based suffix derived from the sequence and header instead of a random alphanumeric code (default). Ensures reproducible IDs across runs
```


## Metadata
- **Skill**: generated
