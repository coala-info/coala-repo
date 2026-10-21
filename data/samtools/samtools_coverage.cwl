cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- coverage
label: samtools_coverage
doc: 'Produce a histogram or table of coverage per chromosome


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: input_files
  type:
  - 'null'
  - type: array
    items: File
  doc: Input sorted alignment files (index needed for --region).
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: .csi
    required: false
  - pattern: .crai
    required: false
  - pattern: ^.bai
    required: false
  inputBinding:
    position: 104
- id: bam_list
  type:
  - 'null'
  - File
  doc: List of input BAM filenames, one per line.
  inputBinding:
    position: 103
    prefix: --bam-list
- id: min_read_len
  type:
  - 'null'
  - int
  doc: Ignore reads shorter than INT bp [0].
  inputBinding:
    position: 103
    prefix: --min-read-len
- id: min_mq
  type:
  - 'null'
  - int
  doc: Mapping quality threshold [0].
  inputBinding:
    position: 103
    prefix: --min-MQ
- id: min_bq
  type:
  - 'null'
  - int
  doc: Base quality threshold [0].
  inputBinding:
    position: 103
    prefix: --min-BQ
- id: rf
  type:
  - 'null'
  - string
  doc: 'Required flags: skip reads with mask bits unset.'
  inputBinding:
    position: 103
    prefix: --rf
- id: ff
  type:
  - 'null'
  - string
  doc: 'Filter flags: skip reads with mask bits set [UNMAP,SECONDARY,QCFAIL,DUP].'
  inputBinding:
    position: 103
    prefix: --ff
- id: depth
  type:
  - 'null'
  - int
  doc: Maximum allowed coverage depth [1000000]; 0 removes the limit.
  inputBinding:
    position: 103
    prefix: --depth
- id: min_depth
  type:
  - 'null'
  - int
  doc: Minimum coverage depth below which a position is ignored [1].
  inputBinding:
    position: 103
    prefix: --min-depth
- id: histogram
  type:
  - 'null'
  - boolean
  doc: Show histogram instead of tabular output.
  inputBinding:
    position: 103
    prefix: --histogram
- id: plot_depth
  type:
  - 'null'
  - boolean
  doc: Plot depth instead of tabular output.
  inputBinding:
    position: 103
    prefix: --plot-depth
- id: ascii
  type:
  - 'null'
  - boolean
  doc: Show only ASCII characters in histogram.
  inputBinding:
    position: 103
    prefix: --ascii
- id: output_filename
  type: string
  doc: Write output to this file (-o).
  default: coverage.txt
  inputBinding:
    position: 103
    prefix: -o
- id: no_header
  type:
  - 'null'
  - boolean
  doc: Do not print a header in tabular mode.
  inputBinding:
    position: 103
    prefix: --no-header
- id: n_bins
  type:
  - 'null'
  - int
  doc: Number of bins in histogram [terminal width - 40].
  inputBinding:
    position: 103
    prefix: --n-bins
- id: region
  type:
  - 'null'
  - string
  doc: Show specified region, format chr:start-end.
  inputBinding:
    position: 103
    prefix: --region
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence FASTA file.
  secondaryFiles:
  - pattern: .fai
    required: false
  inputBinding:
    position: 103
    prefix: --reference
- id: verbosity
  type:
  - 'null'
  - int
  doc: Set level of verbosity.
  inputBinding:
    position: 103
    prefix: --verbosity
- id: input_fmt_option
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --input-fmt-option
  doc: Specify a single input file format option in the form OPTION or OPTION=VALUE (repeatable).
  inputBinding:
    position: 103
outputs:
- id: output
  type: File
  doc: Coverage table or histogram.
  outputBinding:
    glob: $(inputs.output_filename)
