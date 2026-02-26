# coptr CWL Generation Report

## coptr_index

### Tool Description
Index a reference FASTA file for use with coptr.

### Metadata
- **Docker Image**: quay.io/biocontainers/coptr:1.1.4--pyhdfd78af_3
- **Homepage**: https://github.com/tyjo/coptr
- **Package**: https://anaconda.org/channels/bioconda/packages/coptr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/coptr/overview
- **Total Downloads**: 923
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tyjo/coptr
- **Stars**: N/A
### Original Help Text
```text
usage: coptr index [-h] [--bt2-bmax BT2_BMAX] [--bt2-dcv BT2_DCV] [--bt2-threads BT2_THREADS] [--bt2-packed] ref-fasta index-out

positional arguments:
  ref_fasta             File or folder containing fasta to index. If a folder,
                        the extension for each fasta must be one of [.fasta,
                        .fna, .fa]
  index_out             Filepath to store index.

optional arguments:
  -h, --help            show this help message and exit
  --bt2-bmax BT2_BMAX   Set the --bmax arguement for bowtie2-build. Used to
                        control memory useage.
  --bt2-dcv BT2_DCV     Set the --dcv argument for bowtie2-build. Used to
                        control memory usage.
  --bt2-threads BT2_THREADS
                        Number of threads to pass to bowtie2-build.
  --bt2-packed          Set the --packed flag for bowtie2-build. Used to
                        control memory usage.
```


## coptr_map

### Tool Description
Map reads to a database index.

### Metadata
- **Docker Image**: quay.io/biocontainers/coptr:1.1.4--pyhdfd78af_3
- **Homepage**: https://github.com/tyjo/coptr
- **Package**: https://anaconda.org/channels/bioconda/packages/coptr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: coptr map [-h] [--threads INT] [--bt2-k INT] [--paired] index input out-folder

positional arguments:
  index              Name of database index.
  input              File or folder containing fastq reads to map. If a
                     folder, the extension for each fastq must be one of
                     [.fastq, .fq, .fastq.gz, fq.gz]
  out_folder         Folder to save mapped reads. BAM files are output here.

optional arguments:
  -h, --help         show this help message and exit
  --paired           Set for paired end reads. Assumes fastq files end in _1.*
                     and _2.*
  --threads THREADS  Number of threads for bowtie2 mapping.
  --bt2-k BT2_K      (Default 10). Number of alignments to report. Passed to
                     -k flag of bowtie2.
```


## coptr_merge

### Tool Description
Merges multiple BAM files into a single BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/coptr:1.1.4--pyhdfd78af_3
- **Homepage**: https://github.com/tyjo/coptr
- **Package**: https://anaconda.org/channels/bioconda/packages/coptr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: coptr merge [-h] in-bam1 in-bam2 ... in-bamN out-bam

positional arguments:
  in-bams     A space separated list of BAM files to merge. Assumes same reads
              were mapped against different indexes. Only keeps read 1 of
              paired end sequencing, since this is used downstream.
  out-bam     Path to merged BAM.

optional arguments:
  -h, --help  show this help message and exit
```


## coptr_extract

### Tool Description
Extract coverage maps from BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/coptr:1.1.4--pyhdfd78af_3
- **Homepage**: https://github.com/tyjo/coptr
- **Package**: https://anaconda.org/channels/bioconda/packages/coptr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: coptr extract [-h] [--ref-genome-regex REF_GENOME_REGEX] [--check-regex] in-folder out-folder

positional arguments:
  in_folder             Folder with BAM files.
  out_folder            Folder to store coverage maps.

optional arguments:
  -h, --help            show this help message and exit
  --ref-genome-regex REF_GENOME_REGEX
                        Regular expression extracting a reference genome id
                        from the sequence id in a bam file.
  --check-regex         Check the regular expression by counting reference
                        genomes without processing.
  --bt2-k BT2_K         Maximum number of alignments.
```


## coptr_estimate

### Tool Description
Estimate PTR table from coverage maps.

### Metadata
- **Docker Image**: quay.io/biocontainers/coptr:1.1.4--pyhdfd78af_3
- **Homepage**: https://github.com/tyjo/coptr
- **Package**: https://anaconda.org/channels/bioconda/packages/coptr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: usage: coptr estimate [-h] [--min-reads MIN_READS] [--min-cov MIN_COV] [--min-samples MIN_SAMPLES] [--threads THREADS] [--plot OUTFOLDER] [--restart] coverage-map-folder out-file
        

positional arguments:
  coverage_map_folder   Folder with coverage maps computed from 'extract'.
  out_file              Filename to store PTR table.

optional arguments:
  -h, --help            show this help message and exit
  --min-reads MIN_READS
                        Minimum number of reads required to compute a PTR
                        (default 5000).
  --min-cov MIN_COV     Fraction of nonzero bins required to compute a PTR
                        (default 0.75).
  --min-samples MIN_SAMPLES
                        CoPTRContig only. Minimum number of samples required
                        to reorder bins (default 5).
  --plot PLOT           Plot model fit and save the results.
  --restart             Restarts the estimation step using the genomes in the
                        coverage-maps-genome folder.
```


## coptr_count

### Tool Description
Computes the PTR table from coverage maps.

### Metadata
- **Docker Image**: quay.io/biocontainers/coptr:1.1.4--pyhdfd78af_3
- **Homepage**: https://github.com/tyjo/coptr
- **Package**: https://anaconda.org/channels/bioconda/packages/coptr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: usage: coptr count [-h] [--min-cov MIN_COV] [--min-samples MIN_SAMPLES] coverage-map-folder out-file
        

positional arguments:
  coverage_map_folder   Folder with coverage maps computed from 'extract'.
  out_file              Filename to store PTR table.

optional arguments:
  -h, --help            show this help message and exit
  --min-cov MIN_COV     Fraction of nonzero bins required to compute a PTR
                        (default 0.75).
  --min-samples MIN_SAMPLES
                        CoPTRContig only. Minimum number of samples required
                        to reorder bins (default 5).
```


## coptr_rabun

### Tool Description
Computes the PTR table from coverage maps.

### Metadata
- **Docker Image**: quay.io/biocontainers/coptr:1.1.4--pyhdfd78af_3
- **Homepage**: https://github.com/tyjo/coptr
- **Package**: https://anaconda.org/channels/bioconda/packages/coptr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: usage: coptr rabun [-h] [--min-reads MIN_READS] [--min-cov MIN_COV] [--min-samples MIN_SAMPLES] coverage-map-folder out-file
        

positional arguments:
  coverage_map_folder   Folder with coverage maps computed from 'extract'.
  out_file              Filename to store PTR table.

optional arguments:
  -h, --help            show this help message and exit
  --min-reads MIN_READS
                        Minimum number of reads required to compute a PTR
                        (default 5000).
  --min-cov MIN_COV     Fraction of nonzero bins required to compute a PTR
                        (default 0.75).
  --min-samples MIN_SAMPLES
                        CoPTRContig only. Minimum number of samples required
                        to reorder bins (default 5).
```


## Metadata
- **Skill**: generated

## coptr

### Tool Description
CoPTR (v1.1.4): Compute PTRs from complete reference genomes and assemblies.

### Metadata
- **Docker Image**: quay.io/biocontainers/coptr:1.1.4--pyhdfd78af_3
- **Homepage**: https://github.com/tyjo/coptr
- **Package**: https://anaconda.org/channels/bioconda/packages/coptr/overview
- **Validation**: PASS
### Original Help Text
```text
usage: coptr <command> [options]

command: index            create a bowtie2 index for a reference database
         map              map reads against a reference database
         merge            merge BAM files from reads mapped to multiple indexes
         extract          compute coverage maps from bam files
         estimate         estimate PTRs from coverage maps
         count            compute read counts for each genome after filtering
         rabun            estimate relative abundances for each genomes after filtering

CoPTR (v1.1.4): Compute PTRs from complete reference genomes and assemblies.

positional arguments:
  command     Command to run.

optional arguments:
  -h, --help  show this help message and exit
```

