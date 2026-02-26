# freddie CWL Generation Report

## freddie_freddie_split.py

### Tool Description
Extract alignment information from BAM/SAM file and splits reads into distinct transcriptional intervals

### Metadata
- **Docker Image**: quay.io/biocontainers/freddie:0.4--hdfd78af_0
- **Homepage**: https://github.com/vpc-ccg/freddie
- **Package**: https://anaconda.org/channels/bioconda/packages/freddie/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/freddie/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vpc-ccg/freddie
- **Stars**: N/A
### Original Help Text
```text
usage: freddie_split.py [-h] -b BAM
                        [--consider-nonspliced [CONSIDER_NONSPLICED]] -r READS
                        [READS ...] [-t THREADS]
                        [--contig-min-size CONTIG_MIN_SIZE] [-o OUTDIR]

Extract alignment information from BAM/SAM file and splits reads into distinct
transcriptional intervals

options:
  -h, --help            show this help message and exit
  -b BAM, --bam BAM     Path to sorted and indexed BAM file of reads. Assumes
                        splice aligner is used to the genome. Prefers deSALT
  --consider-nonspliced [CONSIDER_NONSPLICED]
                        Consider reads with no splicing
  -r READS [READS ...], --reads READS [READS ...]
                        Space separated paths to reads in FASTQ or FASTA
                        format used to extract polyA tail information. If the
                        file ends with .gz, it will be read using gzip
  -t THREADS, --threads THREADS
                        Number of threads. Max # of threads used is # of
                        contigs. Default: 1
  --contig-min-size CONTIG_MIN_SIZE
                        Minimum contig size. Any contig with less size will
                        not be processes. Default: 1,000,000
  -o OUTDIR, --outdir OUTDIR
                        Path to output directory. Default: freddie_split/
```


## freddie_freddie_segment.py

### Tool Description
Cluster aligned reads into isoforms

### Metadata
- **Docker Image**: quay.io/biocontainers/freddie:0.4--hdfd78af_0
- **Homepage**: https://github.com/vpc-ccg/freddie
- **Package**: https://anaconda.org/channels/bioconda/packages/freddie/overview
- **Validation**: PASS

### Original Help Text
```text
usage: freddie_segment.py [-h] -s SPLIT_DIR [--consider-ends [CONSIDER_ENDS]]
                          [-o OUTDIR] [-t THREADS] [-sd SIGMA]
                          [-tp THRESHOLD_RATE] [-vf VARIANCE_FACTOR]
                          [-mps MAX_PROBLEM_SIZE]
                          [-lo MIN_READ_SUPPORT_OUTSIDE]

Cluster aligned reads into isoforms

options:
  -h, --help            show this help message and exit
  -s SPLIT_DIR, --split-dir SPLIT_DIR
                        Path to Freddie split directory of the reads
  --consider-ends [CONSIDER_ENDS]
                        Consider the start and end splice sites in
                        segmentation
  -o OUTDIR, --outdir OUTDIR
                        Path to output directory. Default: freddie_segment/
  -t THREADS, --threads THREADS
                        Number of threads for multiprocessing. Default: 1
  -sd SIGMA, --sigma SIGMA
                        Sigma value for gaussian_filter1d
  -tp THRESHOLD_RATE, --threshold-rate THRESHOLD_RATE
                        Threshold rate above which the read will be considered
                        as covering a segment. Low threshold is
                        1-threshold_rate. Anything in between is considered
                        ambigious. Default: 0.9. Note: the stricter threshold
                        for a given segment length will be used.
  -vf VARIANCE_FACTOR, --variance-factor VARIANCE_FACTOR
                        The stdev factor to fix a candidate peak. The
                        threshold is set as > mean(non-zero support for
                        splicing postions)+variance_factor*stdev(non-zero
                        support for splicing postions). Default 3.0
  -mps MAX_PROBLEM_SIZE, --max-problem-size MAX_PROBLEM_SIZE
                        Maximum number of candidate breakpoints allowed per
                        segmentation problem
  -lo MIN_READ_SUPPORT_OUTSIDE, --min-read-support-outside MIN_READ_SUPPORT_OUTSIDE
                        Minimum reads support for splice site to support a
                        breakpoint
```


## freddie_freddie_cluster.py

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/freddie:0.4--hdfd78af_0
- **Homepage**: https://github.com/vpc-ccg/freddie
- **Package**: https://anaconda.org/channels/bioconda/packages/freddie/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/freddie_cluster.py", line 13, in <module>
    from gurobipy import Model, GRB, quicksum, LinExpr
ModuleNotFoundError: No module named 'gurobipy'
```


## freddie_freddie_isoforms.py

### Tool Description
Extract alignment information from BAM/SAM file and splits reads into distinct
transcriptional intervals

### Metadata
- **Docker Image**: quay.io/biocontainers/freddie:0.4--hdfd78af_0
- **Homepage**: https://github.com/vpc-ccg/freddie
- **Package**: https://anaconda.org/channels/bioconda/packages/freddie/overview
- **Validation**: PASS

### Original Help Text
```text
usage: freddie_isoforms.py [-h] -s SPLIT_DIR -c CLUSTER_DIR
                           [-m MAJORITY_THRESHOLD] [-w CORRECTION_WINDOW]
                           [-t THREADS] [-o OUTPUT]

Extract alignment information from BAM/SAM file and splits reads into distinct
transcriptional intervals

options:
  -h, --help            show this help message and exit
  -s SPLIT_DIR, --split-dir SPLIT_DIR
                        Path to directory of Freddie segment
  -c CLUSTER_DIR, --cluster-dir CLUSTER_DIR
                        Path to directory of Freddie cluster
  -m MAJORITY_THRESHOLD, --majority-threshold MAJORITY_THRESHOLD
                        Majority threshold of reads to adjust exon boundary
                        using the original alignments. Default: 0.5
  -w CORRECTION_WINDOW, --correction-window CORRECTION_WINDOW
                        The +/- window around segment boundary to look for
                        read alignment boundaries to use for correcting the
                        exon boundaries. Value of 0 means no correction.
                        Default 8.
  -t THREADS, --threads THREADS
                        Number of threads to use
  -o OUTPUT, --output OUTPUT
                        Path to output file. Default: freddie_isoforms.gtf
```

