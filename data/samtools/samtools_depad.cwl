cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- depad
label: samtools_depad
doc: 'Convert a padded BAM to an unpadded BAM


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: input_file
  type: File
  doc: Input BAM file with padded alignments.
  inputBinding:
    position: 104
- id: output_sam
  type:
  - 'null'
  - boolean
  doc: Output is SAM (default is BAM).
  inputBinding:
    position: 103
    prefix: -s
- id: input_sam
  type:
  - 'null'
  - boolean
  doc: Input is SAM (default is BAM).
  inputBinding:
    position: 103
    prefix: -S
- id: uncompressed
  type:
  - 'null'
  - boolean
  doc: Uncompressed BAM output (cannot be used with -s).
  inputBinding:
    position: 103
    prefix: -u
- id: fast_compression
  type:
  - 'null'
  - boolean
  doc: Fast compression BAM output (cannot be used with -s).
  inputBinding:
    position: 103
    prefix: '-1'
- id: reference
  type:
  - 'null'
  - File
  doc: Padded reference sequence file (-T).
  secondaryFiles:
  - pattern: .fai
    required: false
  inputBinding:
    position: 103
    prefix: --reference
- id: output_filename
  type: string
  doc: Output file name (-o).
  default: depadded.bam
  inputBinding:
    position: 103
    prefix: -o
- id: no_pg
  type:
  - 'null'
  - boolean
  doc: Do not add a PG line.
  inputBinding:
    position: 103
    prefix: --no-PG
- id: output_fmt
  type:
  - 'null'
  - string
  doc: Output format FORMAT[,OPT[=VAL]]... (SAM, BAM, CRAM).
  inputBinding:
    position: 103
    prefix: --output-fmt
- id: write_index
  type:
  - 'null'
  - boolean
  doc: Automatically index the output file.
  inputBinding:
    position: 103
    prefix: --write-index
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
- id: output_fmt_option
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --output-fmt-option
  doc: Specify a single output file format option in the form OPTION or OPTION=VALUE (repeatable).
  inputBinding:
    position: 103
outputs:
- id: output
  type: File
  doc: Depadded alignment file.
  outputBinding:
    glob: $(inputs.output_filename)
- id: output_index
  type:
  - 'null'
  - File
  doc: Index of the output when --write-index is used.
  outputBinding:
    glob:
    - $(inputs.output_filename).bai
    - $(inputs.output_filename).csi
    - $(inputs.output_filename).crai
