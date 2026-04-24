cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- split
label: samtools_split
doc: "Splits a file by read group or tag value into multiple output files.\n\nTool
  homepage: https://github.com/samtools/samtools"
requirements:
- class: InlineJavascriptRequirement
inputs:
- id: merged_bam
  type: File
  doc: Input merged BAM file
  inputBinding:
    position: 1
- id: format_string
  type:
  - 'null'
  - string
  doc: output filename format string
  inputBinding:
    position: 102
    prefix: -f
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
- id: max_split
  type:
  - 'null'
  - int
  doc: limit number of output files from -d to NUM
  inputBinding:
    position: 102
    prefix: --max-split
- id: no_pg
  type:
  - 'null'
  - boolean
  doc: do not add a PG line
  inputBinding:
    position: 102
    prefix: --no-PG
- id: output_fmt
  type:
  - 'null'
  - string
  doc: Specify output format (SAM, BAM, CRAM)
  inputBinding:
    position: 102
    prefix: --output-fmt
- id: output_fmt_option
  type:
  - 'null'
  - type: array
    items: string
  doc: Specify a single output file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 102
    prefix: --output-fmt-option
- id: pad_numbers
  type:
  - 'null'
  - int
  doc: zero-pad numbers in filenames to NUMBER digits
  inputBinding:
    position: 102
    prefix: -p
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence FASTA FILE
  inputBinding:
    position: 102
    prefix: --reference
- id: split_tag
  type:
  - 'null'
  - string
  doc: split by TAG value. TAG value must be a string.
  inputBinding:
    position: 102
    prefix: -d
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional threads to use
  inputBinding:
    position: 102
    prefix: --threads
- id: unaccounted_header
  type:
  - 'null'
  - File
  doc: override the header with FILE2 (-u file only)
  inputBinding:
    position: 102
    prefix: -h
- id: verbose
  type:
  - 'null'
  - boolean
  doc: verbose output
  inputBinding:
    position: 102
    prefix: -v
- id: verbosity
  type:
  - 'null'
  - int
  doc: Set level of verbosity
  inputBinding:
    position: 102
    prefix: --verbosity
- id: write_index
  type:
  - 'null'
  - boolean
  doc: Automatically index the output files
  inputBinding:
    position: 102
    prefix: --write-index
- id: unaccounted_bam_name
  type: string?
  doc: put left-over reads in FILE1
  inputBinding:
    position: 102
    prefix: -u
outputs:
- id: split_files
  type: File[]
  outputBinding:
    glob: "*"
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
