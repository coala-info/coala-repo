# cayman CWL Generation Report

## cayman_annotate_proteome

### Tool Description
Annotate proteome with HMMs

### Metadata
- **Docker Image**: quay.io/biocontainers/cayman:0.10.2--pyh7e72e81_0
- **Homepage**: https://github.com/zellerlab/cayman
- **Package**: https://anaconda.org/channels/bioconda/packages/cayman/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cayman/overview
- **Total Downloads**: 334
- **Last updated**: 2025-12-05
- **GitHub**: https://github.com/zellerlab/cayman
- **Stars**: N/A
### Original Help Text
```text
usage: cayman annotate_proteome [-h] [--cutoffs CUTOFFS]
                                [--output_file OUTPUT_FILE]
                                [--threads THREADS]
                                hmmdb proteins

positional arguments:
  hmmdb                 path to folder containing HMMs
  proteins              path to protein sequences in fasta format

options:
  -h, --help            show this help message and exit
  --cutoffs CUTOFFS     path to file containing HMM-specific p-value cutoffs
  --output_file, -o OUTPUT_FILE
  --threads, -t THREADS
```


## cayman_profile

### Tool Description
Profile reads against an annotation database and BWA index.

### Metadata
- **Docker Image**: quay.io/biocontainers/cayman:0.10.2--pyh7e72e81_0
- **Homepage**: https://github.com/zellerlab/cayman
- **Package**: https://anaconda.org/channels/bioconda/packages/cayman/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cayman profile [-h] [--db_format {bed,hmmer}] [-1 [READS1 ...]]
                      [-2 [READS2 ...]] [--singles [SINGLES ...]]
                      [--orphans [ORPHANS ...]] [--out_prefix OUT_PREFIX]
                      [--min_identity MIN_IDENTITY] [--min_seqlen MIN_SEQLEN]
                      [--cpus_for_alignment CPUS_FOR_ALIGNMENT]
                      annotation_db bwa_index

positional arguments:
  annotation_db         Path to a text file containing the domain annotation.
                        This needs to be a 4-column file such as bed4.
  bwa_index             Path to the bwa reference index.

options:
  -h, --help            show this help message and exit
  --db_format {bed,hmmer}
                        Format of the annotation database.
  -1 [READS1 ...]       A forward/R1 read fastq file. Multiple files can be
                        separated by spaces.
  -2 [READS2 ...]       A reverse/R2 read fastq file. Multiple files can be
                        separated by spaces.
  --singles, -s [SINGLES ...]
                        A single-end library read fastq file. Multiple files
                        can be separated by spaces.
  --orphans [ORPHANS ...]
                        An orphan read fastq file. Multiple files can be
                        separated by spaces.
  --out_prefix, -o OUT_PREFIX
                        Prefix for output files.
  --min_identity MIN_IDENTITY
                        Minimum sequence identity [n_match/length] for an
                        alignment to be considered.
  --min_seqlen MIN_SEQLEN
                        Minimum read length [bp] for an alignment to be
                        considered.
  --cpus_for_alignment, -t CPUS_FOR_ALIGNMENT
```


## Metadata
- **Skill**: generated
