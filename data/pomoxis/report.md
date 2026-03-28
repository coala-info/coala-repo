# pomoxis CWL Generation Report

## pomoxis_mini_assemble

### Tool Description
Assemble fastq/fasta formatted reads and perform POA consensus.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Total Downloads**: 53.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nanoporetech/pomoxis
- **Stars**: N/A
### Original Help Text
```text
mini_assemble [-h] -i <fastq>

Assemble fastq/fasta formatted reads and perform POA consensus.

    -h  show this help text.
    -i  fastx input reads (required).
    -r  reference fasta for reference-guided consensus (instead of de novo assembly)
    -o  output folder (default: assm).
    -p  output file prefix (default: reads).
    -t  number of minimap and racon threads (default: 1).
    -m  number of racon rounds (default: 4).
    -n  number of racon shuffles (default: 1. If not 1, should be >10).
    -w  racon window length (default: 500).
    -k  keep intermediate files (default: delete).
    -K  minimap's -K option (default: 500M).
    -c  trim adapters from reads prior to everything else.
    -e  error correct longest e% of reads prior to assembly, or an estimated coverage (e.g. 2x).
        For an estimated coverage, the -l option must be a fastx or a length (e.g. 4.8mb).
    -l  Reference length, either as a number (e.g. 4.8mb) or fastx from which length will be calculated.
    -x  log all commands before running.
-i must be specified.
```


## pomoxis_mini_align

### Tool Description
Align fastq/a or bam formatted reads to a genome using minimap2.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
mini_align [-h] -r <reference> -i <fastq>

Align fastq/a or bam formatted reads to a genome using minimap2.

    -h  show this help text.
    -r  reference, should be a fasta file. If correspondng minimap indices
        do not exist they will be created. (required).
    -i  fastq/a or bam input reads (required).
    -I  split index every ~NUM input bases (default: 16G, this is larger
        than the usual minimap2 default).
    -d  set the minimap2 preset, e.g. map-ont, asm5, asm10, asm20 [default: map-ont]
    -f  force recreation of index file.
    -a  aggressively extend gaps (sets -A1 -B2 -O2 -E1 for minimap2).
    -P  filter to only primary alignments (i.e. run samtools view -F 2308).
        Deprecated: this filter is now default and can be disabled with -A.
    -y  filter to primary and supplementary alignments (i.e. run samtools view -F 260)
    -A  do not filter alignments, output all.
    -n  sort bam by read name.
    -c  chunk size. Input reads/contigs will be broken into chunks
        prior to alignment.
    -t  alignment threads (default: 1).
    -p  output file prefix (default: reads).
    -m  fill MD tag.
    -s  fill cs(=long) tag.
    -C  copy comments from fastx info lines to bam tags.
    -T  which input bam tags to retain if input is in bam format (implies -C, default: '*').
    -X  only create reference index files.
    -x  log all commands before running.
    -M  match score. 
    -S  mismatch score.
    -O  open gap penalty.
    -E  extend gap penalty.
-r must be specified.
```


## pomoxis_stats_from_bam

### Tool Description
Parse a bamfile (from a stream) and output summary stats for each read.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: stats_from_bam [-h] [--bed BED] [-m MIN_LENGTH] [-a] [-o OUTPUT]
                      [-s SUMMARY] [-t THREADS]
                      bam

Parse a bamfile (from a stream) and output summary stats for each read.

positional arguments:
  bam                   Path to bam file.

optional arguments:
  -h, --help            show this help message and exit
  --bed BED             .bed file of reference regions to include. (default:
                        None)
  -m MIN_LENGTH, --min_length MIN_LENGTH
  -a, --all_alignments  Include secondary and supplementary alignments.
                        (default: False)
  -o OUTPUT, --output OUTPUT
                        Output alignment stats to file instead of stdout.
                        (default: <_io.TextIOWrapper name='<stdout>' mode='w'
                        encoding='utf-8'>)
  -s SUMMARY, --summary SUMMARY
                        Output summary to file instead of stderr. (default:
                        <_io.TextIOWrapper name='<stderr>' mode='w'
                        encoding='utf-8'>)
  -t THREADS, --threads THREADS
                        Number of threads for parallel processing. (default:
                        1)
```


## pomoxis_filter_bam

### Tool Description
Filter a bam

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter_bam [-h] [-O {fwd,rev}] [-q QUALITY] [-a ACCURACY] [-c COVERAGE]
                  [-l LENGTH] [--keep_unmapped]
                  [--primary_only | --keep_supplementary] [-o OUTPUT_BAM]
                  [-r REGION] [-t THREADS]
                  bam

Filter a bam

positional arguments:
  bam                   input bam file.

optional arguments:
  -h, --help            show this help message and exit
  --primary_only        Use only primary reads. (default: True)
  --keep_supplementary  Include supplementary alignments. (default: False)
  -o OUTPUT_BAM, --output_bam OUTPUT_BAM
                        Output bam file. (default: filtered.bam)
  -r REGION, --region REGION
                        Only process given region. (default: None)
  -t THREADS, --threads THREADS
                        Number of parallel threads for io processing.
                        (default: 1)

Read filtering options:
  -O {fwd,rev}, --orientation {fwd,rev}
                        Sample only forward or reverse reads. (default: None)
  -q QUALITY, --quality QUALITY
                        Filter reads by mean qscore. (default: None)
  -a ACCURACY, --accuracy ACCURACY
                        Filter reads by accuracy. (default: None)
  -c COVERAGE, --coverage COVERAGE
                        Filter reads by coverage (what fraction of the read
                        aligns). (default: None)
  -l LENGTH, --length LENGTH
                        Filter reads by read length. (default: None)
  --keep_unmapped       Include unmapped reads. (default: False)
```


## pomoxis_subsample_bam

### Tool Description
Subsample a bam to uniform or proportional depth

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: subsample_bam [-h] [-O {fwd,rev}] [-q QUALITY] [-a ACCURACY]
                     [-c COVERAGE] [-l LENGTH] [--keep_unmapped]
                     [--primary_only | --keep_supplementary]
                     [-o OUTPUT_PREFIX] [-r REGIONS [REGIONS ...]]
                     [-p PROFILE] [-t THREADS] [--force_low_depth]
                     [--any_fail | --all_fail] [-x PATIENCE] [-s STRIDE] [-P]
                     [-S SEED]
                     bam depth [depth ...]

Subsample a bam to uniform or proportional depth

positional arguments:
  bam                   input bam file.
  depth                 Target depth.

optional arguments:
  -h, --help            show this help message and exit
  --primary_only        Use only primary reads. (default: True)
  --keep_supplementary  Include supplementary alignments. (default: False)
  -o OUTPUT_PREFIX, --output_prefix OUTPUT_PREFIX
                        Output prefix (default: sub_sampled)
  -r REGIONS [REGIONS ...], --regions REGIONS [REGIONS ...]
                        Only process given regions. (default: None)
  -p PROFILE, --profile PROFILE
                        Stride in genomic coordinates for depth profile.
                        (default: 1000)
  -t THREADS, --threads THREADS
                        Number of threads to use. (default: -1)
  --force_low_depth     Force saving reads mapped to a sequence with coverage
                        below the expected value. (default: False)
  --any_fail            Exit with an error if any region has insufficient
                        coverage. (default: False)
  --all_fail            Exit with an error if all regions have insufficient
                        coverage. (default: False)

Read filtering options:
  -O {fwd,rev}, --orientation {fwd,rev}
                        Sample only forward or reverse reads. (default: None)
  -q QUALITY, --quality QUALITY
                        Filter reads by mean qscore. (default: None)
  -a ACCURACY, --accuracy ACCURACY
                        Filter reads by accuracy. (default: None)
  -c COVERAGE, --coverage COVERAGE
                        Filter reads by coverage (what fraction of the read
                        aligns). (default: None)
  -l LENGTH, --length LENGTH
                        Filter reads by read length. (default: None)
  --keep_unmapped       Include unmapped reads. (default: False)

Uniform sampling options:
  -x PATIENCE, --patience PATIENCE
                        Maximum iterations with no change in median coverage
                        before aborting. (default: 5)
  -s STRIDE, --stride STRIDE
                        Stride in genomic coordinates when searching for new
                        reads. Smaller can lead to more compact pileup.
                        (default: 1000)

Proportional sampling options:
  -P, --proportional    Activate proportional sampling, thus keeping depth
                        variations of the pileup. (default: False)
  -S SEED, --seed SEED  Random seed for proportional downsampling of reads.
                        (default: None)
```


## pomoxis_assess_assembly

### Tool Description
Calculate accuracy statistics for an assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
assess_assembly [-h] -r <reference> -i <fastq>

Calculate accuracy statistics for an assembly.

    -h  show this help text.
    -r  reference, should be a fasta file. If correspondng minimap2 indices
        do not exist they will be created. (required).
    -i  fastq/a input assembly (required).
    -d  set the minimap2 preset, e.g. map-ont, asm5, asm10, asm20 [default: map-ont].
    -c  chunk size. Input reads/contigs will be broken into chunks
        prior to alignment, 0 will not chunk (default 100000).
    -C  catalogue errors.
    -H  count homopolymers.
    -t  alignment threads (default: 1).
    -p  output file prefix (default: assm).
    -b  .bed file of reference regions to assess.
    -l  list all indels at least this long (default: 0, set to 0 to skip searching for indels).
    -e  use with -l option to create a .bed file to exclude indels. If the -b option is used, the two bed files will be combined.
    -y  include supplementary alignments.
    -a  accumulate the stats over a number of chunks, can include multiple values separated by comma,
        one summary file will be generated for each value [default: 10,100].
-i and -r must be specified.
```


## pomoxis_intersect_assembly_errors

### Tool Description
Assess errors which occur in the same reference position accross multiple assemblies.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
intersect_assembly_errors [-h] -r <reference> -i <fasta>

Assess errors which occur in the same reference position accross multiple assemblies. 

    -h  show this help text.
    -r  reference, should be a fasta file. If correspondng bwa indices
        do not exist they will be created. (required).
    -i  fasta input assemblies (required).
    -t  alignment threads (default: 1).
    -o  output directory (default: compare_assm).
-i, and -r must be specified.
```


## Metadata
- **Skill**: generated
