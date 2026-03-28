# td2 CWL Generation Report

## td2_TD2.LongOrfs

### Tool Description
Finds the longest ORFs in transcripts.

### Metadata
- **Docker Image**: quay.io/biocontainers/td2:1.0.7--pyhdfd78af_0
- **Homepage**: https://github.com/Markusjsommer/TD2
- **Package**: https://anaconda.org/channels/bioconda/packages/td2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/td2/overview
- **Total Downloads**: 972
- **Last updated**: 2026-01-14
- **GitHub**: https://github.com/Markusjsommer/TD2
- **Stars**: N/A
### Original Help Text
```text
Python 3.12.12 | packaged by conda-forge | (main, Oct 22 2025, 23:25:55) [GCC 14.3.0] 

Step 1: Initializing args and loading inputs...
usage: TD2.LongOrfs [-h] -t TRANSCRIPTS [-O OUTPUT_DIR] [--precise]
                    [-m MINIMUM_LENGTH] [-M ABSOLUTE_MIN] [-L LEN_SCALE] [-S]
                    [-G GENETIC_CODE] [--complete-orfs-only] [--alt-start]
                    [--all-stopless] [--top TOP]
                    [--gene-trans-map GENE_TRANS_MAP] [-v] [-@ THREADS]
                    [-% MEMORY_THRESHOLD]

options:
  -h, --help            show this help message and exit
  -O OUTPUT_DIR, --output-dir OUTPUT_DIR
                        path to output results, default=./{transcripts}
  --precise             set --precise to enable precise mode. Equivalent to -m
                        98 -M 98 for TD2.LongOrfs, default=False
  -m MINIMUM_LENGTH, --min-length MINIMUM_LENGTH
                        minimum protein length for proteins in long
                        transcripts, default=90
  -M ABSOLUTE_MIN, --absolute-min-length ABSOLUTE_MIN
                        minimum protein length for proteins in short
                        transcripts, default=90
  -L LEN_SCALE, --length-scale LEN_SCALE
                        allow short ORFs in short transcripts if the ORF is at
                        least a fraction of the total transcript length,
                        default=1.1 (essentially off by default). You must
                        also specify -M to a lower minimum ORF length to work
                        with -L
  -S, --strand-specific
                        set -S for strand-specific ORFs (only analyzes top
                        strand), default=False
  -G GENETIC_CODE, --genetic-code GENETIC_CODE
                        genetic code (NCBI integer code), default=1
                        (universal)
  --complete-orfs-only  ignore all ORFs without both a stop and start codon,
                        default=False
  --alt-start           include alternative initiator codons, default=False
  --all-stopless        report stopless sequences rather than ORFs, i.e. never
                        require a start codon, default=False
  --top TOP             record the top N CDS transcripts by length, default=0
  --gene-trans-map GENE_TRANS_MAP
                        gene-to-transcript mapping file (tab-delimited)
  -v, --verbose         set -v for verbose output, default=False
  -@ THREADS, --threads THREADS
                        number of threads to use, default=20
  -% MEMORY_THRESHOLD, --memory-threshold MEMORY_THRESHOLD
                        percent of available memory to use per batch,
                        default=None

required arguments:
  -t TRANSCRIPTS        REQUIRED path to transcripts.fasta
```


## td2_TD2.Predict

### Tool Description
Predicts ORFs from transcripts.

### Metadata
- **Docker Image**: quay.io/biocontainers/td2:1.0.7--pyhdfd78af_0
- **Homepage**: https://github.com/Markusjsommer/TD2
- **Package**: https://anaconda.org/channels/bioconda/packages/td2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: TD2.Predict [-h] -t TRANSCRIPTS [--precise] [-P PSAURON_CUTOFF]
                   [--all-good] [--retain-mmseqs-hits RETAIN_MMSEQS_HITS]
                   [--retain-blastp_hits RETAIN_BLASTP_HITS]
                   [--retain-hmmer_hits RETAIN_HMMER_HITS]
                   [--retain-long-orfs-mode RETAIN_LONG_ORFS_MODE]
                   [--retain-long-orfs-fdr RETAIN_LONG_ORFS_FDR]
                   [--retain-long-orfs-length RETAIN_LONG_ORFS_LENGTH]
                   [--discard-encapsulated] [--complete-orfs-only]
                   [--psauron-all-frame] [-G GENETIC_CODE] [-O OUTPUT_DIR]
                   [-v]

options:
  -h, --help            show this help message and exit
  --precise             set --precise to enable precise mode. Equivalent to -P
                        0.9 and --retain-long-orfs-fdr 0.005 for TD2.Predict,
                        default=False
  -P PSAURON_CUTOFF     minimum in-frame PSAURON score required to report ORF
                        assuming no homology hits, higher is less sensitive
                        and more precise (range: [0,1]; default: 0.50)
  --all-good            report all ORFs that pass PSAURON and/or length-based
                        false discovery filters, default=False
  --retain-mmseqs-hits RETAIN_MMSEQS_HITS
                        mmseqs output in '.m8' format. Complete ORFs with a
                        MMseqs2 match will be retained in the final output.
  --retain-blastp_hits RETAIN_BLASTP_HITS
                        blastp output in '-outfmt 6' format. Complete ORFs
                        with a blastp match will be retained in the final
                        output.
  --retain-hmmer_hits RETAIN_HMMER_HITS
                        domain table output file from running hmmer to search
                        Pfam. Complete ORFs with a Pfam domain hit will be
                        retained in the final output.
  --retain-long-orfs-mode RETAIN_LONG_ORFS_MODE
                        dynamic: retain ORFs longer than a threshold length
                        determined by calculating the FDR for each
                        transcript's GC percent; strict: retain ORFs with
                        length above constant length
  --retain-long-orfs-fdr RETAIN_LONG_ORFS_FDR
                        in "--retain-long-orfs-mode dynamic" mode, set the
                        False Discovery Rate used to calculate dynamic
                        threshold, default=0.10
  --retain-long-orfs-length RETAIN_LONG_ORFS_LENGTH
                        in "--retain-long-orfs-mode strict" mode, retain all
                        ORFs found that are equal or longer than these many
                        nucleotides even if no other evidence marks it as
                        coding, default=100000
  --discard-encapsulated
                        retain ORFs that are fully contained within larger
                        ORFs, default=False
  --complete-orfs-only  discard all ORFs without both a stop and start codon,
                        default=False
  --psauron-all-frame   require ORF to have highest PSAURON score compared to
                        all other reading frames, set this argument for less
                        sensitive and more precise ORFs, can dramatically
                        increase compute time requirements, default=False
  -G GENETIC_CODE       genetic code a.k.a. translation table, NCBI integer
                        codes, default=1
  -O OUTPUT_DIR         same output directory from LongOrfs
  -v, --verbose         verbose output with progress bars, default=False

required arguments:
  -t TRANSCRIPTS        REQUIRED path to transcripts.fasta
```


## Metadata
- **Skill**: generated
