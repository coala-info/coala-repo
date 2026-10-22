# sequenoscope CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| sequenoscope_analyze | PASS |  |
| sequenoscope_filter_ONT | PASS |  |
| sequenoscope_plot | PASS |  |

## sequenoscope_analyze

### Tool Description
Map reads to a target and produce a report with sequencing statistics

### Metadata
- **Docker Image**: quay.io/biocontainers/sequenoscope:1.0.0--pyh7e72e81_1
- **Homepage**: https://github.com/phac-nml/sequenoscope
- **Package**: https://anaconda.org/channels/bioconda/packages/sequenoscope/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sequenoscope analyze --input_fastq <file.fq> --input_reference <ref.fasta> -o <out> -seq_type <sr> [options]
For help use: sequenoscope analyze -h or --help

sequenoscope version 1.0.0: a flexible tool for processing multiplatform sequencing data: analyze, subset/filter, compare and visualize.

options:
  -h, --help            show this help message and exit
  --force               Force overwrite of existing results directory.
  -v, --version         show program's version number and exit

USER OPTIONS:
  Direct input files and basic parameters.

  --input_fastq  [ ...]
                        [REQUIRED] Path to 1 (SE) or 2 (PE) FASTQ files to process.
  --input_reference     [REQUIRED] Path to a single reference FASTA file.
  -seq_sum, --sequencing_summary 
                        (Optional) Path to sequencing summary for manifest creation.
  -o, --output          [REQUIRED] Output directory designation.
  -op, --output_prefix 
                        Output file prefix designation. Default is 'sample'.
  -seq_type, --sequencing_type 
                        [REQUIRED] Sequencing type: 'SE' for single-end or 'PE' for paired-end.

FILTER OPTIONS:
  Parameters to filter/trim FASTQ reads.

  -min_cov, --minimum_coverage 
                        Minimum coverage threshold; default is 1.
  -t, --threads         Number of threads to use.
  -min_len, --minimum_read_length 
                        Minimum read length; default is 15.
  -max_len, --maximum_read_length 
                        Maximum read length; default is 0 (no limit).
  -trm_fr, --trim_front_bp 
                        Bases to trim from the front; default is 0.
  -trm_tail, --trim_tail_bp 
                        Bases to trim from the tail; default is 0.
  -q, --quality_threshold 
                        Quality score threshold; default is 15.
```

## sequenoscope_plot

### Tool Description
Generate plots based on seq manifest files

### Metadata
- **Docker Image**: quay.io/biocontainers/sequenoscope:1.0.0--pyh7e72e81_1
- **Homepage**: https://github.com/phac-nml/sequenoscope
- **Package**: https://anaconda.org/channels/bioconda/packages/sequenoscope/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sequenoscope plot --test_dir <test_dir_path> --control_dir <control_dir_path> --output_dir <out_path>
For help use: sequenoscope plot -h or sequenoscope plot --help

sequenoscope version 1.0.0: a flexible tool for processing multiplatform sequencing data: analyze, subset/filter, compare and visualize.

Optional Arguments:
  -h, --help            show this help message and exit

Required Paths:
  Specify the necessary directories for the tool.

  -T, --test_dir TEST_DIR
                        Path to test directory.
  -C, --control_dir CONTROL_DIR
                        Path to control directory.
  -o, --output_dir OUTPUT_DIR
                        Output directory designation.
  --force               Force overwrite of existing results directory.

Plotting Options:
  Customize the appearance and data for plots.

  -op, --output_prefix OUTPUT_PREFIX
                        Output prefix added before plot names. Default is 'sample'.
  -AS, --adaptive_sampling
                        Generate decision bar charts for adaptive sampling if utilized during sequencing.
  -VP, --violin_data_percent VIOLIN_DATA_PERCENT
                        Fraction of the data to use for the violin plot. Default=0.1.
  -bin, --time_bin_unit {seconds,minutes,5m,15m,hours}
                        Time bin used for decision bar charts.
```

## sequenoscope_filter_ONT

### Tool Description
Filter reads from a fastq file based on a sequencing summary file

### Metadata
- **Docker Image**: quay.io/biocontainers/sequenoscope:1.0.0--pyh7e72e81_1
- **Homepage**: https://github.com/phac-nml/sequenoscope
- **Package**: https://anaconda.org/channels/bioconda/packages/sequenoscope/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sequenoscope filter_ONT --input_fastq <file.fq> --input_summary <seq_summary.txt> -o <out.fastq> [options]
For help use: sequenoscope filter_ONT -h or sequenoscope filter_ONT --help

sequenoscope version 1.0.0: a flexible tool for processing multiplatform sequencing data: analyze, subset/filter, compare and visualize.

Arguments:
  -h, --help            show this help message and exit
  --input_fastq  [ ...]
                        Path to adaptive sequencing fastq files to process. Not required when using --summarize.
  --input_summary       [REQUIRED] Path to ONT sequencing summary file.
  -o, --output          [REQUIRED] Output directory designation
  -op, --output_prefix 
                        Output file prefix designation. default is [sample]
  -cls, --classification 
                        Adaptive-sampling sequencing decision classification based on the 'end_reason' column in the sequencing summary file. Options:
                          - 'unblocked': 'data_service_unblock_mux_change'
                          - 'stop_receiving': 'signal_positive'
                          - 'no_decision': ('signal_negative', 'unblock_mux_change')
                          - 'all': Includes all classifications.
                        Default: 'all'.
  -min_ch, --minimum_channel 
                        Minimum channel number for filtering reads. Default=1.
  -max_ch, --maximum_channel 
                        Maximum channel number for filtering reads. Default=512.
  -min_dur, --minimum_duration 
                        Minimum duration (s) for filtering reads. Default=0.
  -max_dur, --maximum_duration 
                        Maximum duration (s) for filtering reads. Default=100.
  -min_start, --minimum_start_time 
                        Minimum start time (s) for filtering reads. Default=0.
  -max_start, --maximum_start_time 
                        Maximum start time (s) for filtering reads. Default=259200.
  -min_q, --minimum_q_score 
                        Minimum Q score for filtering reads. Default=0.
  -max_q, --maximum_q_score 
                        Maximum Q score for filtering reads. Default=100.
  -min_len, --minimum_length 
                        Minimum read length for filtering. Default=0.
  -max_len, --maximum_length 
                        Maximum read length for filtering. Default=50000.
  --force               Force overwrite of existing results directory
  --summarize           Generate barcode statistics only. This mode works exclusively with the
                        '--input_summary' argument. You must specify both '--input_summary' and
                        '--output' when using this option. The output is a CSV file containing barcode-level statistics, including:
                          - Barcode ID
                          - Total number of reads per barcode
                          - Minimum, maximum, and mean channel numbers
                          - Minimum, maximum, and mean start times (s)
                          - Minimum, maximum, and mean read durations (s)
                          - Minimum, maximum, and mean sequence lengths (bp)
                          - Minimum, maximum, and mean quality scores (Q).
                        This file provides a detailed summary of sequencing metrics per barcode.
  -v, --version         show program's version number and exit
```

## Metadata
- **Skill**: generated
