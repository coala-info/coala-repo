# deblur CWL Generation Report

## deblur_build-biom-table

### Tool Description
Generate a BIOM table from a directory of chimera removed fasta files

### Metadata
- **Docker Image**: quay.io/biocontainers/deblur:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/biocore/deblur
- **Package**: https://anaconda.org/channels/bioconda/packages/deblur/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deblur/overview
- **Total Downloads**: 532.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biocore/deblur
- **Stars**: N/A
### Original Help Text
```text
Usage: deblur build-biom-table [OPTIONS] SEQS_FP OUTPUT_BIOM_FP

  Generate a BIOM table from a directory of chimera removed fasta files
  Parameters ---------- seqs_fp : str   the path to the directory containing
  the chimera removed fasta files output_biom_fp : str   the path where to
  save the output biom table files   ('all.biom', 'reference-hit.biom',
  'reference-non-hit.biom') file_type : str   the files type to add to the
  table   (default='.trim.derep.no_artifacts.msa.deblur.no_chimeras',   can be
  '.fasta' or '.fa' if needed)

Options:
  --min-reads INTEGER        In output biom table - keep only sequences
                             appearing at least min-reads in all samples
                             combined.  [default: 10]
  --file_type TEXT           ending of files to be added to the biom table
                             [default: .fasta.trim.derep.no_artifacts.msa.debl
                             ur.no_chimeras]
  --log-level INTEGER RANGE  Level of messages for log file(range 1-debug to
                             5-critical  [default: 2; 1<=x<=5]
  --log-file PATH            log file name  [default: deblur.log]
  --help                     Show this message and exit.
```


## deblur_build-db-index

### Tool Description
Preapare the artifacts database

### Metadata
- **Docker Image**: quay.io/biocontainers/deblur:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/biocore/deblur
- **Package**: https://anaconda.org/channels/bioconda/packages/deblur/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: deblur build-db-index [OPTIONS] REF_FP OUTPUT_DIR

  Preapare the artifacts database

  Input: ref_fp - the fasta sequence database for artifact removal output_dir
  - the directory to where to write the indexed database

Options:
  --log-level INTEGER RANGE  Level of messages for log file(range 1-debug to
                             5-critical  [default: 2; 1<=x<=5]
  --log-file PATH            log file name  [default: deblur.log]
  --help                     Show this message and exit.
```


## deblur_deblur-seqs

### Tool Description
Clean read errors from Illumina reads

### Metadata
- **Docker Image**: quay.io/biocontainers/deblur:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/biocore/deblur
- **Package**: https://anaconda.org/channels/bioconda/packages/deblur/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: deblur deblur-seqs [OPTIONS] SEQS_FP

  Clean read errors from Illumina reads

Options:
  -m, --mean-error FLOAT     The mean per nucleotide error, used for original
                             sequence estimate. If not passed typical illumina
                             error rate is used  [default: 0.005]
  -d, --error-dist TEXT      A comma separated list of error probabilities for
                             each hamming distance. The length of the list
                             determines the number of hamming distances taken
                             into account.  [default: 1, 0.06, 0.02, 0.02,
                             0.01, 0.005, 0.005, 0.005, 0.001, 0.001, 0.001,
                             0.0005]
  -i, --indel-prob FLOAT     Insertion/deletion (indel) probability (same for
                             N indels)
  --indel-max INTEGER        Maximal indel number
  --log-level INTEGER RANGE  Level of messages for log file(range 1-debug to
                             5-critical  [default: 2; 1<=x<=5]
  --log-file PATH            log file name  [default: deblur.log]
  --help                     Show this message and exit.
```


## deblur_dereplicate

### Tool Description
Dereplicate FASTA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/deblur:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/biocore/deblur
- **Package**: https://anaconda.org/channels/bioconda/packages/deblur/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: deblur dereplicate [OPTIONS] SEQS_FP OUTPUT_FP

  Dereplicate FASTA sequences.

  Dereplicate input FASTA sequences and remove clusters with fewer than
  minimum number of occurrences (set by --min-size).

Options:
  --min-size INTEGER         Discard sequences with an abundance value smaller
                             than min-size  [default: 2]
  --log-level INTEGER RANGE  Level of messages for log file(range 1-debug to
                             5-critical  [default: 2; 1<=x<=5]
  --log-file PATH            log file name  [default: deblur.log]
  --help                     Show this message and exit.
```


## deblur_multiple-seq-alignment

### Tool Description
Multiple sequence alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/deblur:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/biocore/deblur
- **Package**: https://anaconda.org/channels/bioconda/packages/deblur/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: deblur multiple-seq-alignment [OPTIONS] SEQS_FP OUTPUT_FP

  Multiple sequence alignment

Options:
  -a, --threads-per-sample INTEGER
                                  Number of threads to use per sample (0 to
                                  use all)  [default: 1]
  --log-level INTEGER RANGE       Level of messages for log file(range 1-debug
                                  to 5-critical  [default: 2; 1<=x<=5]
  --log-file PATH                 log file name  [default: deblur.log]
  --help                          Show this message and exit.
```


## deblur_remove-artifacts

### Tool Description
Filter artifacts from input sequences based on database(s) provided with the
  --ref-fp (raw FASTA file) or --ref-db-fp (indexed database) options.

### Metadata
- **Docker Image**: quay.io/biocontainers/deblur:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/biocore/deblur
- **Package**: https://anaconda.org/channels/bioconda/packages/deblur/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: deblur remove-artifacts [OPTIONS] SEQS_FP OUTPUT_DIR

  Filter artifacts.

  Filter artifacts from input sequences based on database(s) provided with the
  --ref-fp (raw FASTA file) or --ref-db-fp (indexed database) options.

Options:
  --ref-fp PATH                   Keep all sequences aligning to this FASTA
                                  database (for multiple databases, use --ref-
                                  fp db1.fa --ref-fp db2.fa ..) default for
                                  positive filtering is:
                                  /usr/local/lib/python3.10/site-
                                  packages/deblur/support_files/88_otus.fasta
                                  default for negative filtering is:
                                  /usr/local/lib/python3.10/site-
                                  packages/deblur/support_files/artifacts.fa
  --ref-db-fp PATH                Keep all sequences aligning to this indexed
                                  database. For multiple databases, the order
                                  must follow that of --ref-fp, for example,
                                  --ref-db-fp db1.idx --ref-db-fp db2.idx ..
  -n, --negate / --only-pos       Use --negate (i.e. True) to discard all
                                  sequences aligning to the database passed
                                  via --neg-ref-fp option. Alternatively, use
                                  --only-pos (i.e. False) to filter by only
                                  keeping sequences similar to ones in --pos-
                                  ref-fp.  [default: negate]
  -a, --threads-per-sample INTEGER
                                  Number of threads to use per sample (0 to
                                  use all)  [default: 1]
  --log-level INTEGER RANGE       Level of messages for log file(range 1-debug
                                  to 5-critical  [default: 2; 1<=x<=5]
  --log-file PATH                 log file name  [default: deblur.log]
  --help                          Show this message and exit.
```


## deblur_remove-chimeras-denovo

### Tool Description
Remove chimeras de novo using UCHIME (VSEARCH implementation)

### Metadata
- **Docker Image**: quay.io/biocontainers/deblur:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/biocore/deblur
- **Package**: https://anaconda.org/channels/bioconda/packages/deblur/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: deblur remove-chimeras-denovo [OPTIONS] SEQS_FP OUTPUT_FP

  Remove chimeras de novo using UCHIME (VSEARCH implementation)

Options:
  --log-level INTEGER RANGE  Level of messages for log file(range 1-debug to
                             5-critical  [default: 2; 1<=x<=5]
  --log-file PATH            log file name  [default: deblur.log]
  --help                     Show this message and exit.
```


## deblur_trim

### Tool Description
Trim FASTA sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/deblur:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/biocore/deblur
- **Package**: https://anaconda.org/channels/bioconda/packages/deblur/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: deblur trim [OPTIONS] SEQS_FP OUTPUT_FP

  Trim FASTA sequences

Options:
  -t, --trim-length INTEGER  Sequence trim length  [required]
  --log-level INTEGER RANGE  Level of messages for log file(range 1-debug to
                             5-critical  [default: 2; 1<=x<=5]
  --log-file PATH            log file name  [default: deblur.log]
  --help                     Show this message and exit.
```


## deblur_workflow

### Tool Description
Launch deblur workflow

### Metadata
- **Docker Image**: quay.io/biocontainers/deblur:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/biocore/deblur
- **Package**: https://anaconda.org/channels/bioconda/packages/deblur/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: deblur workflow [OPTIONS]

  Launch deblur workflow

Options:
  --seqs-fp PATH                  Either a Demultiplexed FASTA or FASTQ file
                                  including all samples, or a directory of
                                  per-sample FASTA or FASTQ files. Gzip'd
                                  files are acceptable (e.g., .fastq.gz).
                                  [required]
  --output-dir PATH               Directory path to store output including
                                  BIOM table  [required]
  -t, --trim-length INTEGER       Sequence trim length. All reads shorter than
                                  the trim-length will be discarded. A value
                                  of -1 can be specified to skip trimming;
                                  this assumes all sequences have an identical
                                  length.  [required]
  --left-trim-length INTEGER      Trim the first N bases from every sequence.
                                  A value of 0 disables this trim.  [default:
                                  0]
  --pos-ref-fp PATH               Positive reference filtering database. Keep
                                  all sequences permissively aligning to any
                                  sequence in this FASTA file; these results
                                  are stored in the reference-hit.biom output
                                  file. This defaults to the Greengenes 13_8
                                  OTUs at 88% identity. An e-value threshold
                                  of 10 is used with SortMeRNA against the
                                  reference. For multiple databases, specify
                                  the argument multiple times, e.g., --pos-
                                  ref-fp db1.fa --pos-ref-fp db2.fa
  --pos-ref-db-fp PATH            An indexed version of the positive filtering
                                  database. This can be useful to avoid
                                  incurring the expense of reindexing on every
                                  run. If not supplied, deblur will index the
                                  database. For multiple databases, the order
                                  must follow that of --pos-ref-fp, for
                                  example, --pos-ref-db-fp db1.idx --pos-ref-
                                  db-fp db2.idx ..
  --neg-ref-fp PATH               Negative (artifacts) filtering database.
                                  Drop all sequences which align to any record
                                  in this FASTA file. This defaults to a
                                  database composed of multiple PhiX genomes
                                  and known Illumina adapters. For multiple
                                  databases, specify the argument mutiple
                                  times, e.g., --neg-ref-fp db1.fa --neg-ref-
                                  fp db2.fa
  --neg-ref-db-fp PATH            An indexed version of the negative filtering
                                  database. If not supplied, deblur will index
                                  the database.For multiple databases, the
                                  order must follow that of --neg-ref-fp, for
                                  example, --neg-ref-db-fp db1.idx --neg-ref-
                                  db-fp db2.idx ..
  -w, --overwrite                 Overwrite output directory if exists.
  -m, --mean-error FLOAT          The mean per nucleotide error rate, used for
                                  original sequence estimate. If not passed
                                  typical illumina error rate is used.
                                  [default: 0.005]
  -d, --error-dist TEXT           A comma separated list of error
                                  probabilities for each Hamming distance. The
                                  length of the list determines the number of
                                  Hamming distances taken into account.
                                  [default: 1, 0.06, 0.02, 0.02, 0.01, 0.005,
                                  0.005, 0.005, 0.001, 0.001, 0.001, 0.0005]
  -i, --indel-prob FLOAT          Insertion/deletion (indel) probability. This
                                  probability consistent for multiple indels;
                                  there is not an added elongation penalty.
                                  [default: 0.01]
  --indel-max INTEGER             Maximum number of allowed indels.  [default:
                                  3]
  --min-reads INTEGER             Keep only the sequences which appear at
                                  least min-reads study wide (as opposed to
                                  per-sample).  [default: 10]
  --min-size INTEGER              Keep only sequences which appear at least
                                  min-size times per-sample (as opposed to
                                  study wide).  [default: 2]
  -a, --threads-per-sample INTEGER
                                  Number of threads to use per sample (0 to
                                  use all)  [default: 1]
  --keep-tmp-files                Keep temporary files (useful for debugging)
  --log-level INTEGER RANGE       Level of messages for log file(range 1-debug
                                  to 5-critical  [default: 2; 1<=x<=5]
  --log-file PATH                 log file name  [default: deblur.log]
  -O, --jobs-to-start INTEGER     Number of jobs to start (if to run in
                                  parallel)  [default: 1]
  --is-worker-thread              indicates this is not the main deblur
                                  process (used by the parallel deblur - do
                                  not use manually)
  --help                          Show this message and exit.
```

