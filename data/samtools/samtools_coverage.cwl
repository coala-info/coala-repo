cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- coverage
label: samtools_coverage
doc: "Produces a histogram or tabular summary of coverage for input BAM files.\n\n\
  Tool homepage: https://github.com/samtools/samtools"
requirements:
- class: InlineJavascriptRequirement
inputs:
- id: input_files
  type: File[]
  doc: Input BAM file(s)
  inputBinding:
    position: 1
- id: ascii
  type: boolean?
  doc: show only ASCII characters in histogram
  inputBinding:
    position: 102
    prefix: --ascii
- id: bam_list
  type: File?
  doc: list of input BAM filenames, one per line
  inputBinding:
    position: 102
    prefix: --bam-list
- id: depth
  type: int?
  doc: maximum allowed coverage depth. If 0, depth is set to the maximum integer
    value.
  inputBinding:
    position: 102
    prefix: --depth
- id: ff
  type: string?
  doc: 'filter flags: skip reads with mask bits set'
  inputBinding:
    position: 102
    prefix: --ff
- id: histogram
  type: boolean?
  doc: show histogram instead of tabular output
  inputBinding:
    position: 102
    prefix: --histogram
- id: input_fmt_option
  type: string[]?
  doc: Specify a single input file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 102
    prefix: --input-fmt-option
- id: min_bq
  type: int?
  doc: base quality threshold
  inputBinding:
    position: 102
    prefix: --min-BQ
- id: min_depth
  type: int?
  doc: minimum coverage depth below which a position to be ignored
  inputBinding:
    position: 102
    prefix: --min-depth
- id: min_mq
  type: int?
  doc: mapping quality threshold
  inputBinding:
    position: 102
    prefix: --min-MQ
- id: min_read_len
  type: int?
  doc: ignore reads shorter than INT bp
  inputBinding:
    position: 102
    prefix: --min-read-len
- id: n_bins
  type: int?
  doc: number of bins in histogram [terminal width - 40]
  inputBinding:
    position: 102
    prefix: --n-bins
- id: no_header
  type: boolean?
  doc: don't print a header in tabular mode
  inputBinding:
    position: 102
    prefix: --no-header
- id: plot_depth
  type: boolean?
  doc: plot depth instead of tabular output
  inputBinding:
    position: 102
    prefix: --plot-depth
- id: reference
  type: File?
  doc: Reference sequence FASTA FILE
  inputBinding:
    position: 102
    prefix: --reference
- id: region
  type: string?
  doc: 'show specified region. Format: chr:start-end.'
  inputBinding:
    position: 102
    prefix: --region
- id: rf
  type: string
  doc: 'required flags: skip reads with mask bits unset'
  inputBinding:
    position: 102
    prefix: --rf
- id: verbosity
  type: int?
  doc: Set level of verbosity
  inputBinding:
    position: 102
    prefix: --verbosity
stdout: coverage.txt
outputs:
- id: output
  type: stdout
  doc: write output to FILE
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
