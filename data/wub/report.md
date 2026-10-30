# wub CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| wub_add_errors.py | PASS |  |
| wub_annotate_length.py | PASS |  |
| wub_bam_accuracy.py | PASS |  |
| wub_bam_alignment_length.py | PASS |  |
| wub_bam_alignment_qc.py | PASS | tested on primary and supplementary alignments; the script crashes on secondary alignments that have no sequence |
| wub_bam_alignments_compare.py | Failed | image problem: the script calls odict.values()[0] (Python 2 code), which raises TypeError after the comparison; no report or tsv is written (tested on SAM input, BAM input needs an index that name-sorted BAM cannot have) |
| wub_bam_count_reads.py | PASS | option -g crashes on secondary alignments that have no sequence; tested without them |
| wub_bam_cov.py | PASS |  |
| wub_bam_fill_unaligned.py | PASS |  |
| wub_bam_frag_coverage.py | PASS |  |
| wub_bam_gc_vs_qual.py | PASS | tested on primary and supplementary alignments; the script crashes on secondary alignments that have no sequence |
| wub_bam_multi_qc.py | PASS |  |
| wub_bam_ref_base_coverage.py | PASS |  |
| wub_bam_ref_tab.py | PASS |  |
| wub_bam_score_filter.py | PASS |  |
| wub_bam_soft_clips_tab.py | PASS |  |
| wub_bias_explorer.py | PASS |  |
| wub_calculate_coverage.py | PASS |  |
| wub_compare_genomes_dnadiff.py | Failed | image problem: the dnadiff program (MUMmer) is not installed in the image |
| wub_compare_genomes_lastal.py | Failed | image problem: the lastal program is not installed in the image |
| wub_convert_alphabet.py | PASS |  |
| wub_correlate_counts.py | PASS |  |
| wub_fasta_to_mock_fastq.py | PASS |  |
| wub_fastq_qual_tab.py | PASS |  |
| wub_fastq_time_slice.py | PASS |  |
| wub_fastq_time_tab.py | PASS |  |
| wub_fastx_ends_tab.py | PASS |  |
| wub_fastx_grep.py | PASS |  |
| wub_fastx_length_tab.py | PASS |  |
| wub_length_normalise_counts.py | PASS |  |
| wub_merge_tsvs.py | PASS |  |
| wub_multi_length_hist.py | Failed | image problem: the script calls close() on the Biopython sequence iterator, which no longer has it (AttributeError), for fastq and fasta input |
| wub_pickle_cat.py | PASS |  |
| wub_plot_counts_correlation.py | Failed | image problem: the script passes stat_func to seaborn jointplot, which the installed seaborn rejects (TypeError) |
| wub_plot_gffcmp_stats.py | PASS |  |
| wub_plot_qualities.py | PASS |  |
| wub_plot_sequence_properties.py | PASS |  |
| wub_reads_across_time.py | PASS |  |
| wub_reads_stats.py | PASS |  |
| wub_reverse_fastq.py | PASS |  |
| wub_sequence_filter.py | Failed | tool bug: option -c (reverse complement) drops the read names and writes '<unknown id>' headers; filtering without -c is correct |
| wub_sequence_subtract.py | PASS |  |
| wub_simulate_errors.py | PASS |  |
| wub_simulate_genome.py | PASS |  |
| wub_simulate_sequences.py | PASS |  |
| wub_simulate_sequencing_simple.py | PASS |  |
| wub_split_fastx.py | PASS |  |

## wub_bam_accuracy.py

### Tool Description
Produce accuracy statistics of the input BAM file. Calculates global accuracy and identity and various per-read statistics. The input BAM file must be sorted by coordinates and indexed.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Total Downloads**: 27.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nanoporetech/wub
- **Stars**: N/A
### Original Help Text
```text
usage: bam_accuracy.py [-h] [-c region] [-g global_tsv] [-l read_tsv]
                       [-t bam_tag] [-q aqual] [-e] [-r report_pdf]
                       [-p results_pickle] [-Q]
                       bam

Produce accuracy statistics of the input BAM file. Calculates global accuracy
and identity and various per-read statistics. The input BAM file must be
sorted by coordinates and indexed.

positional arguments:
  bam                Input BAM file.

optional arguments:
  -h, --help         show this help message and exit
  -c region          BAM region (None).
  -g global_tsv      Tab separated file to save global statistics (None).
  -l read_tsv        Tab separated file to save per-read statistics (None).
  -t bam_tag         Dataset tag (BAM basename).
  -q aqual           Minimum alignment quality (0).
  -e                 Include hard and soft clipps in alignment length when
                     calculating accuracy (False).
  -r report_pdf      Report PDF (bam_accuracy.pdf).
  -p results_pickle  Save pickled results in this file (None).
  -Q                 Be quiet and do not print progress bar (False).
```


## wub_bam_cov.py

### Tool Description
Produce refrence coverage table.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bam_cov.py [-h] -f reference [-c region] [-t tsv] [-q aqual] [-Q] bam

Produce refrence coverage table.

positional arguments:
  bam           Input BAM file.

optional arguments:
  -h, --help    show this help message and exit
  -f reference  Reference fasta.
  -c region     BAM region (None).
  -t tsv        Output TSV (bam_cov.tsv).
  -q aqual      Minimum alignment quality (0).
  -Q            Be quiet and do not show progress bars.
```


## wub_bam_frag_coverage.py

### Tool Description
Produce aggregated and individual plots of fragment coverage.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bam_frag_coverage.py [-h] -f reference [-c region] [-i intervals]
                            [-b bins] [-x] [-o] [-t bam_tag] [-q aqual]
                            [-l cov80_tsv] [-g glob_cov80_tsv] [-r report_pdf]
                            [-p results_pickle] [-Q]
                            bam

Produce aggregated and individual plots of fragment coverage.

positional arguments:
  bam                Input BAM file.

optional arguments:
  -h, --help         show this help message and exit
  -f reference       Reference fasta.
  -c region          BAM region (None).
  -i intervals       Length intervals ().
  -b bins            Number of bins (None = auto).
  -x                 Plot per-reference information.
  -o                 Do not take log of coverage.
  -t bam_tag         Dataset tag (BAM basename).
  -q aqual           Minimum alignment quality (0).
  -l cov80_tsv       Tab separated file with per-chromosome cov80 scores
                     (None). Requires the -x option to be specified.
  -g glob_cov80_tsv  Tab separated file with global cov80 score (None).
  -r report_pdf      Report PDF (bam_frag_coverage.pdf).
  -p results_pickle  Save pickled results in this file (None).
  -Q                 Be quiet and do not show progress bars.
```


## wub_fastq_time_tab.py

### Tool Description
Produce a tab separated file with read start times, read and channel numbers sorted by start time.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastq_time_tab.py [-h] [-t read_tsv] fastq

Produce a tab separated file with read start times, read and channel numbers
sorted by start time.

positional arguments:
  fastq        Input fastq file.

optional arguments:
  -h, --help   show this help message and exit
  -t read_tsv  Tab separated file to save read time table.
```

## wub_fastx_ends_tab.py

### Tool Description
Generate a tab separated file with the first and last -n bases of the sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastx_ends_tab.py [-h] [-i in_format] [-n nr_bases]
                         [input_fastx] [output_tsv]

Generate a tab separated file with the first and last -n bases of the
sequences.

positional arguments:
  input_fastx   Input file (default: stdin).
  output_tsv    Output file (default: stdout).

optional arguments:
  -h, --help    show this help message and exit
  -i in_format  Input format (fastq).
  -n nr_bases   .
```

## wub_fastx_grep.py

### Tool Description
Filter sequence files by read name.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastx_grep.py [-h] [-i in_format] [-o out_format] [-n read_names]
                     [input_fastx] [output_fastx]

Filter sequence files by read name.

positional arguments:
  input_fastx    Input file (default: stdin).
  output_fastx   Output file (default: stdout).

optional arguments:
  -h, --help     show this help message and exit
  -i in_format   Input format (fastq).
  -o out_format  Output format (fastq).
  -n read_names  Comma separated list of read names to select.
```

## wub_fastx_length_tab.py

### Tool Description
Generate a tab separated file with the sequence lengths in the input file.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastx_length_tab.py [-h] [-i in_format] [input_fastx] [output_tsv]

Generate a tab separated file with the sequence lengths in the input file.

positional arguments:
  input_fastx   Input file (default: stdin).
  output_tsv    Output file (default: stdout).

optional arguments:
  -h, --help    show this help message and exit
  -i in_format  Input format (fasta).
```

## wub_length_normalise_counts.py

### Tool Description
Calculate RPKM values from raw counts and a transcriptome reference.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: length_normalise_counts.py [-h] -f in_trs input_counts output_count

Calculate RPKM values from raw counts and a transcriptome reference.

positional arguments:
  input_counts  Input count file.
  output_count  Output RPKM file.

optional arguments:
  -h, --help    show this help message and exit
  -f in_trs     Input transcriptome.
```

## wub_merge_tsvs.py

### Tool Description
Merge tab separated files on a given field using pandas.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: merge_tsvs.py [-h] [-j join] [-f field] [-o out_tsv] [-z]
                     [input_tsvs [input_tsvs ...]]

Merge tab separated files on a given field using pandas.

positional arguments:
  input_tsvs  Input tab separated files.

optional arguments:
  -h, --help  show this help message and exit
  -j join     Join type (outer).
  -f field    Join on this field (Read).
  -o out_tsv  Output tsv (merge_tsvs.tsv).
  -z          Fill NA values with zero.
```

## wub_multi_length_hist.py

### Tool Description
Plot histograms of length distributions from multiple sequence files.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: multi_length_hist.py [-h] [-r report_pdf] [-f in_format] [-b nr_bins]
                            [-l min_len] [-u max_len] [-L]
                            [input_counts [input_counts ...]]

Plot histograms of length distributions from multiple sequence files.

positional arguments:
  input_counts   Input sequence files.

optional arguments:
  -h, --help     show this help message and exit
  -r report_pdf  Report PDF.
  -f in_format   Input format (fastq).
  -b nr_bins     Number of bins (50).
  -l min_len     Minimum read length (None).
  -u max_len     Maximum read length (None).
  -L             Log transform lengths.
```

## wub_pickle_cat.py

### Tool Description
Pretty print the contents of a pickle file.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pickle_cat.py [-h] pickle_file

Pretty print the contents of a pickle file.

positional arguments:
  pickle_file  Input pickle file.

optional arguments:
  -h, --help   show this help message and exit
```

## wub_plot_counts_correlation.py

### Tool Description
Scatter plot of two set of counts.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: plot_counts_correlation.py [-h] [-r report_pdf] [-T tags]
                                  [-t merged_data] [-o Correlation_tsv]
                                  counts_one counts_two

Scatter plot of two set of counts.

positional arguments:
  counts_one          Input tab separated file.
  counts_two          Input tab separated file.

optional arguments:
  -h, --help          show this help message and exit
  -r report_pdf       Report PDF.
  -T tags             Data tags: tag1,tag2.
  -t merged_data      Merged data TSV.
  -o Correlation_tsv  Correlation TSV.
```

## wub_plot_gffcmp_stats.py

### Tool Description
Plot a gffcompare stats file.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: plot_gffcmp_stats.py [-h] [-r report_pdf] [-p pickle_out] input_txt

Plot a gffcompare stats file.

positional arguments:
  input_txt      Input gffcompare stats file.

optional arguments:
  -h, --help     show this help message and exit
  -r report_pdf  Report PDF (plot_gffcmp_stats.pdf).
  -p pickle_out  Output pickle file.
```

## wub_plot_qualities.py

### Tool Description
Plot the mean quality values across non-overlapping windows in the input sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: plot_qualities.py [-h] [-w win_size] [-r report_pdf] [input_fastx]

Plot the mean quality values across non-overlapping windows in the input
sequences.

positional arguments:
  input_fastx    Input (default: stdin).

optional arguments:
  -h, --help     show this help message and exit
  -w win_size    Window size (50).
  -r report_pdf  Report pdf (plot_qualities.pdf).
```

## wub_plot_sequence_properties.py

### Tool Description
Plot histograms of lengths and quality values.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: plot_sequence_properties.py [-h] [-f format] [-b bins] [-r report_pdf]
                                   [-j]
                                   [input_fastx]

Plot histograms of lengths and quality values.

positional arguments:
  input_fastx    Input (default: stdin).

optional arguments:
  -h, --help     show this help message and exit
  -f format      Input format (fastq).
  -b bins        Number of bins on histograms (50).
  -r report_pdf  Report pdf (plot_sequence_properties.pdf).
  -j             Produce joint plot of lengths and mean quality values
                 (False).
```

## wub_reads_across_time.py

### Tool Description
Plot read and alignment properties across time.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: reads_across_time.py [-h] -i time_tab -a aln_tab [-w res_freq]
                            [-r report_pdf] [-t out_tsv]

Plot read and alignment properties across time.

optional arguments:
  -h, --help     show this help message and exit
  -i time_tab    Tab separated file generated by fastq_time_tab.py
  -a aln_tab     Tab separated file generated by bam_alignment_length.py
  -w res_freq    Resampling frequency in minutes.
  -r report_pdf  Report PDF (reads_across_time.pdf).
  -t out_tsv     Output tsv (reads_across_time.tsv).
```

## wub_reads_stats.py

### Tool Description
Calculates the GC content and N50

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: reads_stats.py [-h] --fastx FILE [--raw] [--savepath DIR] [--report]
                      [--tag STR]

Calculates the GC content and N50

optional arguments:
  -h, --help            show this help message and exit
  --fastx FILE, -i FILE
                        input file fastq or fasta
  --raw, -a             save raw the gc content per read/contig.
                        default[False]
  --savepath DIR, -s DIR
                        output dir. default[cwd]
  --report, -r          Report PDF default[False]
  --tag STR, -n STR     output name or tag. default[input name]
```

## wub_reverse_fastq.py

### Tool Description
Reverse (but not complement!) sequences and qualities in fastq file.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: reverse_fastq.py [-h] [input_fastq] [output_fastq]

Reverse (but not complement!) sequences and qualities in fastq file.

positional arguments:
  input_fastq   Input fastq (default: stdin).
  output_fastq  Output fastq (default: stdout)

optional arguments:
  -h, --help    show this help message and exit
```

## wub_sequence_filter.py

### Tool Description
Filter sequences by length and mean quality value.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sequence_filter.py [-h] [-i in_format] [-o out_format] [-q min_qual]
                          [-l min_length] [-c] [-u max_length]
                          [input_fastx] [output_fastx]

Filter sequences by length and mean quality value.

positional arguments:
  input_fastx    Input file (default: stdin).
  output_fastx   Output file (default: stdout).

optional arguments:
  -h, --help     show this help message and exit
  -i in_format   Input format (fastq).
  -o out_format  Output format (fastq).
  -q min_qual    Minimum mean quality value (0.0).
  -l min_length  Minimum length (0).
  -c             Reverse complement sequences.
  -u max_length  Maximum length (None).
```

## wub_sequence_subtract.py

### Tool Description
Filter out sequences present in the first file from the second file.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sequence_subtract.py [-h] [-i in_format] [-o out_format]
                            [input_fastx_bait] [input_fastx_target]
                            [output_fastx]

Filter out sequences present in the first file from the second file.

positional arguments:
  input_fastx_bait    First input file (default: stdin).
  input_fastx_target  Second input file.
  output_fastx        Output file (default: stdout).

optional arguments:
  -h, --help          show this help message and exit
  -i in_format        Input format (fastq).
  -o out_format       Output format (fastq).
```

## wub_simulate_errors.py

### Tool Description
Simulate sequencing errors for each input sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: simulate_errors.py [-h] [-e error_rate] [-w error_weights]
                          [-z random_seed]
                          [input_fasta] [output_fasta]

Simulate sequencing errors for each input sequence.

positional arguments:
  input_fasta       Input fasta (default: stdin).
  output_fasta      Output fasta (default: stdout)

optional arguments:
  -h, --help        show this help message and exit
  -e error_rate     Total rate of substitutions insertions and deletions
                    (0.1).
  -w error_weights  Relative frequency of substitutions,insertions,deletions
                    (1,1,4).
  -z random_seed    Random seed (None).
```

## wub_simulate_genome.py

### Tool Description
Simulate genome sequence with the specified number of chromosomes, length distribution (truncated gamma) and base composition.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: simulate_genome.py [-h] [-n nr_chrom] [-m mean_length] [-a gamma_shape]
                          [-l low_trunc] [-u high_trunc] [-b base_freqs]
                          [-z random_seed]
                          [output_fasta]

Simulate genome sequence with the specified number of chromosomes, length
distribution (truncated gamma) and base composition.

positional arguments:
  output_fasta    Output fasta (default: stdout)

optional arguments:
  -h, --help      show this help message and exit
  -n nr_chrom     Number of chromosomes (23).
  -m mean_length  Mean length of chromosomes (5000000).
  -a gamma_shape  Gamma shape parameter (1).
  -l low_trunc    Lower truncation point (None).
  -u high_trunc   Upper truncation point (None).
  -b base_freqs   Relative base frequencies in A,C,G,T order (1,1,1,1) or
                  "random".
  -z random_seed  Random seed (None).
```

## wub_simulate_sequences.py

### Tool Description
Simulate sequences of fixed length and specified base composition.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: simulate_sequences.py [-h] [-n nr_seq] [-m length] [-b base_freqs]
                             [-z random_seed]
                             [output_fasta]

Simulate sequences of fixed length and specified base composition.

positional arguments:
  output_fasta    Output fasta (default: stdout)

optional arguments:
  -h, --help      show this help message and exit
  -n nr_seq       Number of sequences (1).
  -m length       Length of simulated sequences (3000).
  -b base_freqs   Relative base frequencies in A,C,G,T order (1,1,1,1).
  -z random_seed  Random seed (None).
```

## wub_simulate_sequencing_simple.py

### Tool Description
Sample fragments from the input genome and simulate sequencing errors. Read lengths are drawn from the specified truncated gamma distribution. Chromosomes are sampled randomly for each read. The format of the read names is the following: r<unique_id>_<chromosome>_<frag_start>_<frag_end>_<strand>/q<realis ed_quality>/s<realised_substiutions>/d<realised_deletions>/i<realised_insertio ns>

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: simulate_sequencing_simple.py [-h] [-n nr_reads] [-m mean_length]
                                     [-a gamma_shape] [-l low_trunc]
                                     [-u high_trunc] [-e error_rate]
                                     [-w error_weights] [-b strand_bias]
                                     [-q mock_quality] [-s true_sam] [-Q]
                                     [-z random_seed]
                                     [input_fasta] [output_fastq]

Sample fragments from the input genome and simulate sequencing errors. Read
lengths are drawn from the specified truncated gamma distribution. Chromosomes
are sampled randomly for each read. The format of the read names is the
following: r<unique_id>_<chromosome>_<frag_start>_<frag_end>_<strand>/q<realis
ed_quality>/s<realised_substiutions>/d<realised_deletions>/i<realised_insertio
ns>

positional arguments:
  input_fasta       Input genome in fasta format (default: stdin).
  output_fastq      Output fastq (default: stdout)

optional arguments:
  -h, --help        show this help message and exit
  -n nr_reads       Number of simulated reads (1).
  -m mean_length    Mean read length (5000).
  -a gamma_shape    Read length distribution: gamma shape parameter (1).
  -l low_trunc      Read length distribution: lower truncation point (100).
  -u high_trunc     Read length distribution: upper truncation point (None).
  -e error_rate     Total rate of substitutions insertions and deletions
                    (0.1).
  -w error_weights  Relative frequency of substitutions,insertions,deletions
                    (1,1,4).
  -b strand_bias    Strand bias: the ratio of forward and reverse reads (0.5).
  -q mock_quality   Mock base quality for fastq output (40).
  -s true_sam       Save true alignments in this SAM file (None).
  -Q                Be quiet and do not print progress bar (False).
  -z random_seed    Random seed (None).
```

## wub_split_fastx.py

### Tool Description
Split sequence records in file to one record per file or batches of records.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: split_fastx.py [-h] [-i in_format] [-o out_format] [-b batch_size]
                      [input_fastx] [output_dir]

Split sequence records in file to one record per file or batches of records.

positional arguments:
  input_fastx    Input file (default: stdin).
  output_dir     Output directory (default: .)

optional arguments:
  -h, --help     show this help message and exit
  -i in_format   Input format (fastq).
  -o out_format  Output format (fastq).
  -b batch_size  Batch size (None).
```

## wub_add_errors.py

### Tool Description
Add a specified number of errors to random sites for each input sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: add_errors.py [-h] [-n nr_errors] [-t error_type]
                     [input_fasta] [output_fasta]

Add a specified number of errors to random sites for each input sequence.

positional arguments:
  input_fasta    Input fasta (default: stdin).
  output_fasta   Output fasta (default: stdout)

optional arguments:
  -h, --help     show this help message and exit
  -n nr_errors   Number of errors to introduce (0).
  -t error_type  Error type: substitution, insertion or deletion.
```

## wub_annotate_length.py

### Tool Description
Add sequence length to sequence record descriptions.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: annotate_length.py [-h] [-i in_format] [-o out_format]
                          [input_fastx] [output_fastx]

Add sequence length to sequence record descriptions.

positional arguments:
  input_fastx    Input file (default: stdin).
  output_fastx   Output file (default: stdout).

optional arguments:
  -h, --help     show this help message and exit
  -i in_format   Input format (fastq).
  -o out_format  Output format (fastq).
```

## wub_bam_alignment_length.py

### Tool Description
Produce a tab separated file of alignment lengths and other information. Rows are sorted by number of aligned reference bases unless the -x option is specified.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bam_alignment_length.py [-h] [-t tsv_file] [-q aqual] [-x] [-Q] bam

Produce a tab separated file of alignment lengths and other information. Rows
are sorted by number of aligned reference bases unless the -x option is
specified.

positional arguments:
  bam          Input BAM file.

optional arguments:
  -h, --help   show this help message and exit
  -t tsv_file  Tab separated file to save alignment lengths
               (bam_alignment_length.tsv).
  -q aqual     Minimum alignment quality (0).
  -x           Sort by number of read bases instead of number of aligned
               reference bases.
  -Q           Be quiet and do not print progress bar (False).
```

## wub_bam_alignment_qc.py

### Tool Description
Produce alignment based QC plots of the input BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bam_alignment_qc.py [-h] -f reference [-c region] [-n context_sizes]
                           [-x] [-t bam_tag] [-q aqual] [-i qual_ints]
                           [-r report_pdf] [-p results_pickle] [-Q]
                           bam

Produce alignment based QC plots of the input BAM file. The input BAM file
must be sorted by coordinates and indexed. It produces the following global
plots: * Read statistics: number of mapped, unmapped and low mapping quality
reads. * Distribution of mean quality values in the mapped and unmapped
fractions. * Distribution of read lengths in the unmapped fraction. *
Distribution of read lengths in the mapped fraction. * Distribution of read
lengths in the mapping with quality less than -q * Distribution of alignment
lengths. * Distribution of mapping qualities. * Plot of alignment lengths vs.
mean base qualities. * Basewise statistics: total alignment length, number of
insertions, deleltions, matches and mismatches. * Precision statistics:
accuracy and identity. * Frequency of errors in the context specifed by the
left and right context sizes (-n). Definition of context: for substitutions
the event is happening from the "central base", in the case of indels the
events are located between the central base and the base before. The columns
of the heatmap are normalised to sum to one and then the diagonal element are
set to zero. * Distribution of deletion lengths. * Distribution of insertion
lengths. * Base composition of insertions. The following plots are produced
for every reference unless disabled via -x: * Distribution of quality values
across the reference as a heatmap. * Mean quality values across the reference.
* Base coverage across the reference. The tool saves the gathered statistics
in a pickle file, which can be fed to `bam_multi_qc.py` to compare different
samples.

positional arguments:
  bam                Input BAM file.

optional arguments:
  -h, --help         show this help message and exit
  -f reference       Reference fasta.
  -c region          BAM region (None).
  -n context_sizes   Left and right context sizes (1,1).
  -x                 Do not plot per-reference information.
  -t bam_tag         Dataset tag (BAM basename).
  -q aqual           Minimum alignment quality (0).
  -i qual_ints       Number of quality intervals (6).
  -r report_pdf      Report PDF (bam_alignment_qc.pdf).
  -p results_pickle  Save pickled results in this file (bam_alignment_qc.pk).
  -Q                 Be quiet and do not show progress bars.
```

## wub_bam_alignments_compare.py

### Tool Description
Compare alignments stored in two BAM files. The two BAM files must have the same set of reads in the same order (name sorted).

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bam_alignments_compare.py [-h] [-w coarse_tolerance] [-g]
                                 [-r report_pdf] [-p results_pickle]
                                 [-t tsv_file] [-f format] [-Q]
                                 bam_one bam_two

Compare alignments stored in two BAM files. The two BAM files must have the
same set of reads in the same order (name sorted).

positional arguments:
  bam_one              First input BAM file.
  bam_two              Second input BAM file.

optional arguments:
  -h, --help           show this help message and exit
  -w coarse_tolerance  Tolerance when performing coarse comparison of
                       alignments (50).
  -g                   Do strict comparison of alignment flags.
  -r report_pdf        Report PDF (bam_alignments_compare.pdf).
  -p results_pickle    Save pickled results in this file
                       (bam_alignments_compare.pk).
  -t tsv_file          Save results in tsv format in this file (None).
  -f format            Input format (BAM).
  -Q                   Be quiet and do not print progress bar (False).
```

## wub_bam_count_reads.py

### Tool Description
Count reads mapping to each reference in a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bam_count_reads.py [-h] [-a min_aqual] [-f in_format] [-z ref_fasta]
                          [-k words] [-g] [-p results_pickle] [-t tsv_file]
                          [-Q] [-R] [-F yield_freq]
                          [bam]

Count reads mapping to each reference in a BAM file.

positional arguments:
  bam                Input file (default: stdin).

optional arguments:
  -h, --help         show this help message and exit
  -a min_aqual       Minimum mapping quality (0).
  -f in_format       Input format (BAM).
  -z ref_fasta       Reference fasta. GC content and length columns are added
                     if present (None).
  -k words           Include word frequencies of specifed length in output
                     (None).
  -g                 Include mean GC content of reads mapped to each reference
                     (False).
  -p results_pickle  Save pickled results in this file (None).
  -t tsv_file        Save results in tsv format in this file
                     (bam_count_reads.tsv).
  -Q                 Be quiet and do not print progress bar (False).
  -R                 Count reads from SAM stream in stdin. Only read count
                     fields are written. Header required! (False).
  -F yield_freq      Yield counts after every -Fth mapped record when doing
                     online counting (100).
```

## wub_bam_fill_unaligned.py

### Tool Description
Generate SAM records for the reads present in the input fastq but missing from the input SAM/BAM.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bam_fill_unaligned.py [-h] [-f format] -q fastq input_file output_file

Generate SAM records for the reads present in the input fastq but missing from
the input SAM/BAM.

positional arguments:
  input_file   Input file.
  output_file  Output SAM file.

optional arguments:
  -h, --help   show this help message and exit
  -f format    Input/output format (SAM).
  -q fastq     Input fastq.
```

## wub_bam_gc_vs_qual.py

### Tool Description
Produce a plot of GC content of aligned read and reference portion versus their mean quality values.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bam_gc_vs_qual.py [-h] -f reference [-q aqual] [-r report_pdf] [-t tsv]
                         [-Q]
                         bam

Produce a plot of GC content of aligned read and reference portion versus
their mean quality values.

positional arguments:
  bam            Input BAM file.

optional arguments:
  -h, --help     show this help message and exit
  -f reference   Reference fasta.
  -q aqual       Minimum alignment quality (0).
  -r report_pdf  Report PDF (bam_gc_vs_qual.pdf).
  -t tsv         Tab separated file to save results (bam_gc_vs_qual.tsv).
  -Q             Be quiet and do not show progress bars.
```

## wub_bam_multi_qc.py

### Tool Description
Compare alignment QC statistics of multiple samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bam_multi_qc.py [-h] [-r report_pdf] [-x]
                       [input_pickles [input_pickles ...]]

Compare alignment QC statistics of multiple samples. It takes a list of pickle
files produced by `bam_alignment_qc.py` and produces plots comparing the
following properties of the input samples: * Number of mapped reads. * Number
of unmapped reads. * Distribution of mean quality values in the unaligned
fraction. * Distribution of mean quality values in the aligned fraction. *
Distribution of read lengths in the unaligned fraction. * Distribution of read
lengths in the aligned fraction. * Distribution of alignment lengths. *
Distribution of mapping qualities. * Alignment accuracy. * Alignment identity.
* Distribution of deletion lengths. * Distribution of insertion lengths. Per
reference plots (can be disabled by -x): * Relative coverage across reference.
* Mean qualities per position.

positional arguments:
  input_pickles  Input pickles.

optional arguments:
  -h, --help     show this help message and exit
  -r report_pdf  Report PDF (bam_multi_qc.pdf).
  -x             Do not plot reference statistics.
```

## wub_bam_ref_base_coverage.py

### Tool Description
Calculate percent covered reference lengths.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bam_ref_base_coverage.py [-h] -f reference [-c region] [-t tsv]
                                [-m min_cov] [-Q]
                                bam

Calculate percent covered reference lengths.

positional arguments:
  bam           Input BAM file.

optional arguments:
  -h, --help    show this help message and exit
  -f reference  Reference fasta.
  -c region     BAM region (None).
  -t tsv        Output tab separated file (bam_ref_base_coverage.tsv).
  -m min_cov    Minimum base coverage for a position to be counted (1).
  -Q            Be quiet and do not show progress bars.
```

## wub_bam_ref_tab.py

### Tool Description
Produce a tab separated file with read identifiers and the corresponding references, sorted by reference.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bam_ref_tab.py [-h] [-t read_tsv] [-Q] [-s] bam

Produce a tab separated file with read identifiers and the corresponding
references, sorted by reference.

positional arguments:
  bam          Input BAM file.

optional arguments:
  -h, --help   show this help message and exit
  -t read_tsv  Tab separated file to save reference table.
  -Q           Be quiet and do not print progress bar (False).
  -s           Save read strand in output (False).
```

## wub_bam_score_filter.py

### Tool Description
Filter SAM/BAM records by score or other criteria. WARNING: the input records must be sorted by name or the filtering will not work as expected.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bam_score_filter.py [-h] [-f format] [-s strategy] [-q query_cover]
                           input_file output_file

Filter SAM/BAM records by score or other criteria. WARNING: the input records
must be sorted by name or the filtering will not work as expected.

positional arguments:
  input_file      Input file.
  output_file     Output SAM file.

optional arguments:
  -h, --help      show this help message and exit
  -f format       Input/output format (SAM).
  -s strategy     Filtering strategy: top_per_query, query_coverage,
                  ref_coverage (top_per_query).
  -q query_cover  Minimum query coverage fraction (0.8).
```

## wub_bam_soft_clips_tab.py

### Tool Description
Produce a tab separated file with read identifiers and number of soft clipped bases at each end (relative to the original sequence in the fastq).

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bam_soft_clips_tab.py [-h] [-t tsv] [-Q] bam

Produce a tab separated file with read identifiers and number of soft clipped
bases at each end (relative to the original sequence in the fastq).

positional arguments:
  bam         Input BAM file.

optional arguments:
  -h, --help  show this help message and exit
  -t tsv      Output tab separated file.
  -Q          Be quiet and do not print progress bar (False).
```

## wub_bias_explorer.py

### Tool Description
Simple tool for exploring biases in transcript counts. Takes as input count files generated by bam_count_reads.py (with the -z flag) and performs linear regression of log counts against transcript length and GC content.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bias_explorer.py [-h] [-r report_pdf] [-x] count_file

Simple tool for exploring biases in transcript counts. Takes as input count
files generated by bam_count_reads.py (with the -z flag) and performs linear
regression of log counts against transcript length and GC content.

positional arguments:
  count_file     Input counts file with length ang GC content features.

optional arguments:
  -h, --help     show this help message and exit
  -r report_pdf  Report PDF (bias_explorer.pdf).
  -x             Exclude transcripts with zero counts.
```

## wub_calculate_coverage.py

### Tool Description
Calculate total number of bases and genome coverage if genome size is given.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: calculate_coverage.py [-h] [-f format] [-s genome_size]
                             [-p results_pickle]
                             [input_fastx]

Calculate total number of bases and genome coverage if genome size is given.

positional arguments:
  input_fastx        Input (default: stdin).

optional arguments:
  -h, --help         show this help message and exit
  -f format          Input format (fastq).
  -s genome_size     Genome size (None).
  -p results_pickle  Save pickled results in this file.
```

## wub_compare_genomes_dnadiff.py

### Tool Description
Compare a set of reference sequences (genome) to another set (target assembly) using mummer's dnadiff. It prints the alignment results to stdout. All parsed results can be saved in a pickle file.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: compare_genomes_dnadiff.py [-h] [-p results_pickle] [-r raw_file]
                                  [-d work_dir] [-k] [-v]
                                  reference_fasta target_fasta

Compare a set of reference sequences (genome) to another set (target assembly)
using mummer's dnadiff. It prints the alignment results to stdout. All parsed
results can be saved in a pickle file.

positional arguments:
  reference_fasta    Reference fasta.
  target_fasta       Target fasta.

optional arguments:
  -h, --help         show this help message and exit
  -p results_pickle  Save pickled results in this file (None).
  -r raw_file        Save dnadiff report in this file (None).
  -d work_dir        Use this working directory instead of a temporary
                     directory (None).
  -k                 Keep dnadiff result files (False).
  -v                 Print out dnadiff output (False).
```

## wub_compare_genomes_lastal.py

### Tool Description
Compare a set of reference sequences (genome) to another set (target assembly) using lastal alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: compare_genomes_lastal.py [-h] [-p results_pickle] [-l lastal_args]
                                 [-t details_tsv] [-f] [-r report_pdf]
                                 reference_fasta target_fasta

Compare a set of reference sequences (genome) to another set (target assembly)
using lastal alignment. Accuracy is the total number of matched bases divided
by total alignment length. Coverage is total reference covered by alignment
divided by total length of reference. Caveats: - The lastal alignments are
filtered by default (use -f to disable) so only the best scoring alignment is
kept per query. Hence some shorter valid alignments might be discarded causing
an underestimation of coverage. - The estimated accuracy is dependent on the
scoring of gaps and mismatches. By default gap open and gap extend penalties
are set to equal.

positional arguments:
  reference_fasta    Reference fasta.
  target_fasta       Target fasta.

optional arguments:
  -h, --help         show this help message and exit
  -p results_pickle  Save pickled results in this file (None).
  -l lastal_args     Parameters passed to lastal in the <arg>:value,... format
                     (a:1,b:1).
  -t details_tsv     Save details of lastal alignment in this tab-separated
                     file (None).
  -f                 Do *not* filter for best alignment per query.
  -r report_pdf      Report with alignment details plot (None).
```

## wub_convert_alphabet.py

### Tool Description
Convert between DNA and RNA alphabets.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: convert_alphabet.py [-h] [-i in_format] [-o out_format] [-D] [-R]
                           [input_fastx] [output_fastx]

Convert between DNA and RNA alphabets.

positional arguments:
  input_fastx    Input file (default: stdin).
  output_fastx   Output file (default: stdout).

optional arguments:
  -h, --help     show this help message and exit
  -i in_format   Input format (fastq).
  -o out_format  Output format (fastq).
  -D             RNA->DNA alphabet conversion.
  -R             DNA->RNA alphabet conversion.
```

## wub_correlate_counts.py

### Tool Description
Correlate counts produced by multiple runs of bam_count_reads.py.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: correlate_counts.py [-h] [-r report_pdf] [-c corr_type] [-L] [-o]
                           [input_counts [input_counts ...]]

Correlate counts produced by multiple runs of bam_count_reads.py.

positional arguments:
  input_counts   Input counts as tab separated files.

optional arguments:
  -h, --help     show this help message and exit
  -r report_pdf  Report PDF (bam_multi_qc.pdf).
  -c corr_type   Correlation statistic - spearman or pearson (spearman).
  -L             Log transform data.
  -o             Omit lower diagonal.
```

## wub_fasta_to_mock_fastq.py

### Tool Description
Convert fasta file to fastq with mock qualities.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fasta_to_mock_fastq.py [-h] [-q mock_quals]
                              [input_fasta] [output_fastq]

Convert fasta file to fastq with mock qualities.

positional arguments:
  input_fasta    Input fasta (default: stdin).
  output_fastq   Output fastq (default: stdout)

optional arguments:
  -h, --help     show this help message and exit
  -q mock_quals  Mock quality value (40).
```

## wub_fastq_qual_tab.py

### Tool Description
Generate a table of read names and mean quality values.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastq_qual_tab.py [-h] [-t tsv] [input_fastq]

Generate a table of read names and mean quality values.

positional arguments:
  input_fastq  Input fastq (default: stdin).

optional arguments:
  -h, --help   show this help message and exit
  -t tsv       Output tab separated file.
```

## wub_fastq_time_slice.py

### Tool Description
Filter a fastq file by starting time.

### Metadata
- **Docker Image**: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
- **Homepage**: https://github.com/nanoporetech/wub
- **Package**: https://anaconda.org/channels/bioconda/packages/wub/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastq_time_slice.py [-h] -t time_tsv [-s start_perc] [-e end_perc]
                           [input_fastq] [output_fastq]

Filter a fastq file by starting time.

positional arguments:
  input_fastq    Input fastq (default: stdin).
  output_fastq   Output fastq (default: stdout)

optional arguments:
  -h, --help     show this help message and exit
  -t time_tsv    Tab separeted file produced by fastq_time_tab.py.
  -s start_perc  Start of slice as percent of total time.
  -e end_perc    End of slice as percent of total time.
```

## Metadata
- **Skill**: not generated
