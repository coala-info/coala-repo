# tesorter CWL Generation Report

## tesorter_TEsorter

### Tool Description
lineage-level classification of transposable elements using conserved protein domains.

### Metadata
- **Docker Image**: quay.io/biocontainers/tesorter:1.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/NBISweden/TEsorter
- **Package**: https://anaconda.org/channels/bioconda/packages/tesorter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tesorter/overview
- **Total Downloads**: 29.5K
- **Last updated**: 2025-11-17
- **GitHub**: https://github.com/NBISweden/TEsorter
- **Stars**: N/A
### Original Help Text
```text
usage: TEsorter [-h] [-v]
                [-db {gydb,rexdb,rexdb-plant,rexdb-metazoa,rexdb-v3,rexdb-plantv3,rexdb-metazoav3,rexdb-pnas,rexdb-line,sine}]
                [--db-hmm DB_HMM] [-st {nucl,prot}] [-pre PREFIX] [-fw]
                [-p PROCESSORS] [-tmp TMP_DIR] [-cov MIN_COVERAGE]
                [-eval MAX_EVALUE] [-prob MIN_PROBABILITY] [-score MIN_SCORE]
                [-mask {soft,hard} [{soft,hard} ...]] [-nocln] [-cite] [-dp2]
                [-rule PASS2_RULE] [-nolib] [-norc] [-genome]
                [-win_size WIN_SIZE] [-win_ovl WIN_OVL]
                sequence

lineage-level classification of transposable elements using conserved protein
domains.

positional arguments:
  sequence              input TE/LTR or genome sequences in fasta format
                        [required]

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -db, --hmm-database {gydb,rexdb,rexdb-plant,rexdb-metazoa,rexdb-v3,rexdb-plantv3,rexdb-metazoav3,rexdb-pnas,rexdb-line,sine}
                        the database name used [default=rexdb]
  --db-hmm DB_HMM       the database HMM file used (prior to `-db`)
                        [default=None]
  -st, --seq-type {nucl,prot}
                        'nucl' for DNA or 'prot' for protein [default=nucl]
  -pre, --prefix PREFIX
                        output prefix [default='{-s}.{-db}']
  -fw, --force-write-hmmscan
                        if False, will use the existed hmmscan outfile and
                        skip hmmscan [default=False]
  -p, --processors PROCESSORS
                        processors to use [default=4]
  -tmp, --tmp-dir TMP_DIR
                        directory for temporary files [default=./tmp-
                        efac6f12-1296-11f1-829a-5a7f178de619]
  -cov, --min-coverage MIN_COVERAGE
                        mininum coverage for protein domains in HMMScan output
                        (ranging: 0-100) [default=20]
  -eval, --max-evalue MAX_EVALUE
                        maxinum E-value for protein domains in HMMScan output
                        (ranging: 0-10) [default=0.001]
  -prob, --min-probability MIN_PROBABILITY
                        mininum posterior probability for protein domains in
                        HMMScan output (ranging: 0-1) [default=0.5]
  -score, --min-score MIN_SCORE
                        mininum score for protein domains in HMMScan output
                        (ranging: 0-2) [default=0.1]
  -mask {soft,hard} [{soft,hard} ...]
                        output masked sequences (soft: masking with lowercase;
                        hard: masking with N) [default=None]
  -nocln, --no-cleanup  do not clean up the temporary directory
                        [default=False]
  -cite, --citation     print the citation and exit [default=False]

ELEMENT mode (default):
  Input TE/LTR sequences to classify them into clade-level.

  -dp2, --disable-pass2
                        do not further classify the unclassified sequences
                        [default=False for `nucl`, True for `prot`]
  -rule, --pass2-rule PASS2_RULE
                        classifying rule [identity-coverage-length] in pass-2
                        based on similarity [default=80-80-80]
  -nolib, --no-library  do not generate a library file for RepeatMasker
                        [default=False]
  -norc, --no-reverse   do not reverse complement sequences if they are
                        detected in minus strand [default=False]

GENOME mode:
  Input genome sequences to detect TE protein domains throughout whole
  genome.

  -genome               input is genome sequences [default=False]
  -win_size WIN_SIZE    window size of chunking genome sequences
                        [default=270000]
  -win_ovl WIN_OVL      overlap size of windows [default=30000]
```

