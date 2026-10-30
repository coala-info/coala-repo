# pomoxis CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pomoxis_assess_assembly | PASS |  |
| pomoxis_assess_homopolymers_analyse | PASS | Analysed the homopolymer counts; tables and plots written (4-mer homopolymers called correctly about 67% of the time). |
| pomoxis_assess_homopolymers_count | PASS | Counted homopolymers in 2,500 real ONT reads (Portiera, ENA ERR3772599) aligned to the genome; counts and plots written. |
| pomoxis_catalogue_errors_analyse | PASS | Analysed the error counts; summary tables and plots written. |
| pomoxis_catalogue_errors_count | PASS | Catalogued errors of 179 real ONT reads aligned to Portiera; error summary tables and counts written. |
| pomoxis_common_errors_from_bam | Failed | tool bug: pomoxis 0.3.16 stops with a TypeError (stats_from_aligned_read takes 1 argument but 3 were given) after trimmed assembly alignments were supplied. |
| pomoxis_coverage_from_bam | PASS | Depth table and summary for 2,500 real ONT reads on the 358 kb Portiera genome; mean depth about 10. Region and one-file options also tested. |
| pomoxis_coverage_from_fastx | PASS | Estimated 13.6x coverage from 4.88 Mb of reads and the 358 kb genome; both a file and a length string work. |
| pomoxis_fast_convert | PASS | Converted 100 real ONT reads from fastq to fasta (qa). |
| pomoxis_filter_bam | PASS |  |
| pomoxis_find_indels | PASS | Listed 5,378 indels of at least 5 bp from the real ONT alignments, with a bed file. |
| pomoxis_intersect_assembly_errors | Failed | tool bug: the script calls stats_from_bam --bam, an option that stats_from_bam 0.3.16 in the same image rejects, so it stops after trimming |
| pomoxis_long_fastx | PASS | Split 2,500 real ONT reads: the longest 10% (250 reads) and the other 2,250. |
| pomoxis_mini_align | PASS |  |
| pomoxis_mini_assemble | PASS |  |
| pomoxis_qscores_from_summary | PASS | Median Q scores from the summary; Q(acc) 9.94 matches the summary median. |
| pomoxis_ref_seqs_from_bam | PASS | Extracted the reference segment of each of 2,500 aligned reads; segments match the genome. |
| pomoxis_reverse_bed | PASS | Converted two bed intervals to reverse strand coordinates; values are correct (length minus stop and start). |
| pomoxis_split_fastx | PASS | Split 100 real ONT reads into chunks of at most 1,000 bases. |
| pomoxis_stats_from_bam | PASS |  |
| pomoxis_subsample_bam | PASS |  |
| pomoxis_summary_from_stats | PASS | Summarised stats_from_bam output of real ONT reads; mean error about 12.7%. |
| pomoxis_tag_bam | PASS | Added an integer tag to all alignments (the tool needs an integer value); tag is present in the output bam. |
| pomoxis_trim_alignments | PASS | Trimmed four real overlapping ONT alignments, and also two assembly alignments, to a common window; trimmed queries and reference written. |

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


## pomoxis_assess_homopolymers_count

### Tool Description
Count homopolymers starting from a bam.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: assess_homopolymers count [-h] [-o OUTPUT_DIR] [-t THREADS]
                                 [-l HOMO_LEN] [-b BED]
                                 bam

positional arguments:
  bam                   Input bam file.

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Output directory (will be created). (default:
                        homopolymers)
  -t THREADS, --threads THREADS
                        Number of threads for parallel execution. (default: 1)
  -l HOMO_LEN, --homo_len HOMO_LEN
                        Minimum homopolymer length, default 3 (default: 3)
  -b BED, --bed BED     Bed file to limit search. (default: None)
```

## pomoxis_assess_homopolymers_analyse

### Tool Description
Analyse existing homopolymer counts, optionally merging multiple counters.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: assess_homopolymers analyse [-h] [-o OUTPUT_DIR] pkl [pkl ...]

positional arguments:
  pkl                   Input .pkl file(s).

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Output directory (will be created). (default:
                        homopolymers)
```

## pomoxis_catalogue_errors_count

### Tool Description
Count query errors in a bam.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: catalogue_errors count [-h] [--bed BED] [-t THREADS] [-o OUTDIR] bam

positional arguments:
  bam                   Input alignments (aligned to ref).

optional arguments:
  -h, --help            show this help message and exit
  --bed BED             .bed file of reference regions to include. (default:
                        None)
  -t THREADS, --threads THREADS
                        Number of threads for parallel execution. (default: 1)
  -o OUTDIR, --outdir OUTDIR
                        Output directory. (default: error_catalogue)
```

## pomoxis_catalogue_errors_analyse

### Tool Description
Analyse existing error counts, optionally merging multiple counters.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: catalogue_errors analyse [-h] [-o OUTDIR] pkl [pkl ...]

positional arguments:
  pkl                   Input .pkl file(s).

optional arguments:
  -h, --help            show this help message and exit
  -o OUTDIR, --outdir OUTDIR
                        Output directory (will be created). (default:
                        error_catalogue)
```

## pomoxis_common_errors_from_bam

### Tool Description
Get errors common to multiple assemblies aligned to ref.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: common_errors_from_bam [-h] [-o OUTPUT_PREFIX] bam ref_fasta

Get errors common to multiple assemblies aligned to ref.

positional arguments:
  bam                   input bam file containing assemblies trimmed to a
                        common alignment window
  ref_fasta             reference fasta file of the reference over that
                        alignment window

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT_PREFIX, --output_prefix OUTPUT_PREFIX
                        Prefix for outputs. (default: common_errors)
```

## pomoxis_coverage_from_bam

### Tool Description
Calculate read coverage depth from a bam.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: coverage_from_bam [-h] [-O {fwd,rev}] [-q QUALITY] [-a ACCURACY]
                         [-c COVERAGE] [-l LENGTH] [--keep_unmapped]
                         [--primary_only | --keep_supplementary]
                         [-r REGIONS [REGIONS ...]] [-p PREFIX | -o ONE_FILE]
                         [-s STRIDE] [--summary_only]
                         bam

Calculate read coverage depth from a bam.

positional arguments:
  bam                   .bam/sam file.

optional arguments:
  -h, --help            show this help message and exit
  --primary_only        Use only primary reads. (default: True)
  --keep_supplementary  Include supplementary alignments. (default: False)
  -r REGIONS [REGIONS ...], --regions REGIONS [REGIONS ...]
                        Only process given regions. (default: None)
  -p PREFIX, --prefix PREFIX
                        Prefix for output, defaults to basename of bam.
                        (default: None)
  -o ONE_FILE, --one_file ONE_FILE
                        Single output file with "region" column. (default:
                        None)
  -s STRIDE, --stride STRIDE
                        Stride in genomic coordinate. (default: 1000)
  --summary_only        Output only the depth_summary.txt file (default:
                        False)

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

By default a file is written per reference sequence, this can be changed with
the `--one_file` option. If overlapping regions are specified, `--one_file`
should not be used.
```

## pomoxis_coverage_from_fastx

### Tool Description
Estimate coverage from summed basecall and reference lengths.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: coverage_from_fastx [-h] [--coverage COVERAGE] [--longest]
                           basecalls ref_len

Estimate coverage from summed basecall and reference lengths

positional arguments:
  basecalls            input fastx file.
  ref_len              reference length (e.g. 4.8kb/mb/gb) or reference fastx
                       from which to calculate length.

optional arguments:
  -h, --help           show this help message and exit
  --coverage COVERAGE  Calculate fraction of reads required for this coverage.
                       (default: None)
  --longest            Use the longest reads when calculating fraction reads
                       required for a given coverage. (default: False)
```

## pomoxis_fast_convert

### Tool Description
Convert between fasta<->fastq.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fast_convert [-h] [--discard_q] [--mock_q MOCK_Q] {qq,aa,aq,qa}

Convert between fasta<->fastq.

positional arguments:
  {qq,aa,aq,qa}    Conversion code: from->to.

optional arguments:
  -h, --help       show this help message and exit
  --discard_q      Discard quality information from fastq, use with --mock_q.
                   (default: False)
  --mock_q MOCK_Q  Mock quality value, valid for convert=aq|qq. (default: 10)
```

## pomoxis_find_indels

### Tool Description
Parse a bamfile and document indels.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: find_indels [-h] [-m MIN_INDEL_LENGTH] [-a] [-o OUTPUT] [-b BED]
                   [-t THREADS]
                   bam

Parse a bamfile and document indels.

positional arguments:
  bam                   Path to bam file.

optional arguments:
  -h, --help            show this help message and exit
  -m MIN_INDEL_LENGTH, --min_indel_length MIN_INDEL_LENGTH
                        Filter out indels shorter than this length. (default:
                        0)
  -a, --all_alignments  Include secondary and supplementary alignments.
                        (default: False)
  -o OUTPUT, --output OUTPUT
                        Output indels to file instead of stdout. (default:
                        <_io.TextIOWrapper name='<stdout>' mode='w'
                        encoding='utf-8'>)
  -b BED, --bed BED     Additionaly output a .bed file. (default: None)
  -t THREADS, --threads THREADS
                        Number of threads for parallel processing. (default:
                        1)
```

## pomoxis_long_fastx

### Tool Description
Extract longest reads from a fastq.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: long_fastx [-h] (--longest LONGEST | --bases BASES) [--others OTHERS]
                  input output

Extract longest reads from a fastq.

positional arguments:
  input              Input .fasta/q file.
  output             Output .fasta file.

optional arguments:
  -h, --help         show this help message and exit
  --longest LONGEST  Percentage of longest reads to partition.
  --bases BASES      Maximum number of bases (subject to at least one read.)
  --others OTHERS    Write all other reads to file.
```

## pomoxis_qscores_from_summary

### Tool Description
Extract Q scores from summary_from_stats output.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: qscores_from_summary [-h] [--median] [--ref REF]
                            summaries [summaries ...]

Extract Q scores from summary_from_stats output

positional arguments:
  summaries   *summ.txt created by summary_from_stats

optional arguments:
  -h, --help  show this help message and exit
  --median    Use median. If false, use mean. (default: False)
  --ref REF   process single ref, rather than overall result (default: None)
```

## pomoxis_ref_seqs_from_bam

### Tool Description
Extract reference sequence that queries are aligned to.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ref_seqs_from_bam [-h] bam

Extract reference sequence that queries are aligned to

positional arguments:
  bam         input bam file, MD tag must be set (mini_align -m).

optional arguments:
  -h, --help  show this help message and exit
```

## pomoxis_reverse_bed

### Tool Description
Convert bed-file coordinates to coordinates on the reverse strand.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: reverse_bed [-h] bed_in ref_fasta bed_out

Convert bed-file coordinates to coordinates on the reverse strand.

positional arguments:
  bed_in      Input bed file.
  ref_fasta   Input reference fasta file.
  bed_out     Output bed file.

optional arguments:
  -h, --help  show this help message and exit
```

## pomoxis_split_fastx

### Tool Description
Split records in a fasta/q file into chunks of a maximum size.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: split_fastx [-h] input output chunksize

Split records in a fasta/q file into chunks of a maximum size.

positional arguments:
  input       Input fastax/q file.
  output      Output fastax/q file.
  chunksize   Maximum size of output sequences.

optional arguments:
  -h, --help  show this help message and exit
```

## pomoxis_summary_from_stats

### Tool Description
Summarise output of stats_from_bam.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: summary_from_stats [-h] [-i INPUT] [-o OUTPUT]
                          [-p PERCENTILES [PERCENTILES ...]] [-pr]
                          [-a ACCUMULATE]

Summarise output of `stats_from_bam`.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
  -o OUTPUT, --output OUTPUT
                        Output summary to file instead of stderr. (default:
                        <_io.TextIOWrapper name='<stderr>' mode='w'
                        encoding='utf-8'>)
  -p PERCENTILES [PERCENTILES ...], --percentiles PERCENTILES [PERCENTILES ...]
                        Percentiles for summary. (default: (10, 50, 90))
  -pr, --per_reference  Also output a summary for each reference. (default:
                        False)
  -a ACCUMULATE, --accumulate ACCUMULATE
                        Accumulate chunks in the summary. (default: 1)
```

## pomoxis_tag_bam

### Tool Description
Add a tag to all alignments in a bam.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tag_bam [-h] input output tag_name tag_value

Add a tag to all alignments in a bam.

positional arguments:
  input       Input bam file.
  output      Output output file.
  tag_name    Tag name.
  tag_value   Tag value.

optional arguments:
  -h, --help  show this help message and exit
```

## pomoxis_trim_alignments

### Tool Description
Trim alignments in multiple bams to common overlap window.

### Metadata
- **Docker Image**: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pomoxis
- **Package**: https://anaconda.org/channels/bioconda/packages/pomoxis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: trim_alignments [-h] [-r REF_NAME] [-o OUTPUT_PREFIX]
                       [-f REFERENCE_FASTA]
                       bams [bams ...]

Trim alignments in multiple bams to common overlap window.

positional arguments:
  bams                  input bam files

optional arguments:
  -h, --help            show this help message and exit
  -r REF_NAME, --ref_name REF_NAME
                        Reference to process, only needed if bams contain
                        multiple references. (default: None)
  -o OUTPUT_PREFIX, --output_prefix OUTPUT_PREFIX
                        Prefix for outputs. (default: trimmed)
  -f REFERENCE_FASTA, --reference_fasta REFERENCE_FASTA
                        Reference fasta to trim to alignment window. (default:
                        None)
```

## Metadata
- **Skill**: generated
