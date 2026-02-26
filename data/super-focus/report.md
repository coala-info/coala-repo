# super-focus CWL Generation Report

## super-focus_superfocus

### Tool Description
SUPER-FOCUS: A tool for agile functional analysis of shotgun metagenomic data.

### Metadata
- **Docker Image**: quay.io/biocontainers/super-focus:1.6--pyhdfd78af_1
- **Homepage**: https://edwards.sdsu.edu/SUPERFOCUS
- **Package**: https://anaconda.org/channels/bioconda/packages/super-focus/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/super-focus/overview
- **Total Downloads**: 41.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/metageni/SUPER-FOCUS
- **Stars**: N/A
### Original Help Text
```text
usage: superfocus [-h] [-v] -q QUERY -dir OUTPUT_DIRECTORY [-o OUTPUT_PREFIX]
                  [-tmp TEMP_DIRECTORY] [-a ALIGNER] [-mi MINIMUM_IDENTITY]
                  [-ml MINIMUM_ALIGNMENT] [-t THREADS] [-e EVALUE]
                  [-db DATABASE] [-p AMINO_ACID] [-f FAST]
                  [-n NORMALISE_OUTPUT] [-m FOCUS] [-b ALTERNATE_DIRECTORY]
                  [-d] [-w LATENCY_WAIT] [-s SUBSAMPLE] [-l LOG]

SUPER-FOCUS: A tool for agile functional analysis of shotgun metagenomic data.

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -q QUERY, --query QUERY
                        Path to FAST(A/Q) file or directory with these files.
  -dir OUTPUT_DIRECTORY, --output_directory OUTPUT_DIRECTORY
                        Path to output files
  -o OUTPUT_PREFIX, --output_prefix OUTPUT_PREFIX
                        Output prefix (Default: output).
  -tmp TEMP_DIRECTORY, --temp_directory TEMP_DIRECTORY
                        specify an alternate temporary directory to use
  -a ALIGNER, --aligner ALIGNER
                        aligner choice (rapsearch, diamond, blast, or mmseqs2;
                        default rapsearch).
  -mi MINIMUM_IDENTITY, --minimum_identity MINIMUM_IDENTITY
                        minimum identity (default 60 perc).
  -ml MINIMUM_ALIGNMENT, --minimum_alignment MINIMUM_ALIGNMENT
                        minimum alignment (amino acids) (default: 15).
  -t THREADS, --threads THREADS
                        Number Threads used in the k-mer counting (Default:
                        4).
  -e EVALUE, --evalue EVALUE
                        e-value (default 0.00001).
  -db DATABASE, --database DATABASE
                        database (DB_90, DB_95, DB_98, or DB_100; default
                        DB_90)
  -p AMINO_ACID, --amino_acid AMINO_ACID
                        amino acid input; 0 nucleotides; 1 amino acids
                        (default 0).
  -f FAST, --fast FAST  runs RAPSearch2 or DIAMOND on fast mode - 0 (False) /
                        1 (True) (default: 1).
  -n NORMALISE_OUTPUT, --normalise_output NORMALISE_OUTPUT
                        normalises each query counts based on number of hits;
                        0 doesn't normalize; 1 normalizes (default: 1).
  -m FOCUS, --focus FOCUS
                        runs FOCUS; 1 does run; 0 does not run: default 0.
  -b ALTERNATE_DIRECTORY, --alternate_directory ALTERNATE_DIRECTORY
                        Alternate directory for your databases.
  -d, --delete_alignments
                        Delete alignments
  -w LATENCY_WAIT, --latency_wait LATENCY_WAIT
                        Add a delay (in seconds) between writing the file and
                        reading it
  -s SUBSAMPLE, --subsample SUBSAMPLE
                        subsample the sequences to reduce memory demand and
                        speed up analysis
  -l LOG, --log LOG     Path to log file (Default: STDOUT).

superfocus -q input_folder -dir output_dir
```

