cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - coverage
label: samtools_coverage
doc: "Produces a histogram or tabular summary of coverage for input BAM files.\n\n\
  Tool homepage: https://github.com/samtools/samtools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input BAM file(s)
    inputBinding:
      position: 1
  - id: ascii
    type:
      - 'null'
      - boolean
    doc: show only ASCII characters in histogram
    inputBinding:
      position: 102
      prefix: --ascii
  - id: bam_list
    type:
      - 'null'
      - File
    doc: list of input BAM filenames, one per line
    inputBinding:
      position: 102
      prefix: --bam-list
  - id: depth
    type:
      - 'null'
      - int
    doc: maximum allowed coverage depth. If 0, depth is set to the maximum 
      integer value.
    default: 1000000
    inputBinding:
      position: 102
      prefix: --depth
  - id: ff
    type:
      - 'null'
      - string
    doc: 'filter flags: skip reads with mask bits set'
    default: UNMAP,SECONDARY,QCFAIL,DUP
    inputBinding:
      position: 102
      prefix: --ff
  - id: histogram
    type:
      - 'null'
      - boolean
    doc: show histogram instead of tabular output
    inputBinding:
      position: 102
      prefix: --histogram
  - id: input_fmt_option
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --input-fmt-option
  - id: min_bq
    type:
      - 'null'
      - int
    doc: base quality threshold
    default: 0
    inputBinding:
      position: 102
      prefix: --min-BQ
  - id: min_depth
    type:
      - 'null'
      - int
    doc: minimum coverage depth below which a position to be ignored
    default: 1
    inputBinding:
      position: 102
      prefix: --min-depth
  - id: min_mq
    type:
      - 'null'
      - int
    doc: mapping quality threshold
    default: 0
    inputBinding:
      position: 102
      prefix: --min-MQ
  - id: min_read_len
    type:
      - 'null'
      - int
    doc: ignore reads shorter than INT bp
    default: 0
    inputBinding:
      position: 102
      prefix: --min-read-len
  - id: n_bins
    type:
      - 'null'
      - int
    doc: number of bins in histogram [terminal width - 40]
    inputBinding:
      position: 102
      prefix: --n-bins
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: don't print a header in tabular mode
    inputBinding:
      position: 102
      prefix: --no-header
  - id: plot_depth
    type:
      - 'null'
      - boolean
    doc: plot depth instead of tabular output
    inputBinding:
      position: 102
      prefix: --plot-depth
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA FILE
    inputBinding:
      position: 102
      prefix: --reference
  - id: region
    type:
      - 'null'
      - string
    doc: 'show specified region. Format: chr:start-end.'
    inputBinding:
      position: 102
      prefix: --region
  - id: rf
    type:
      - 'null'
      - string
    doc: 'required flags: skip reads with mask bits unset'
    inputBinding:
      position: 102
      prefix: --rf
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set level of verbosity
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: write output to FILE
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
