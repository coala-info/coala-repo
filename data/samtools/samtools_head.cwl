cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- head
label: samtools_head
doc: "Display header and/or alignment record lines from a SAM, BAM, or CRAM file.\n\
  \nTool homepage: https://github.com/samtools/samtools"
requirements:
  InlineJavascriptRequirement: {}
inputs:
- id: input_file
  type: File
  doc: Input SAM, BAM, or CRAM file
  inputBinding:
    position: 1
- id: headers
  type:
  - "null"
  - int
  - string
  doc: Display INT header lines
  inputBinding:
    position: 102
    prefix: --headers
- id: input_fmt_option
  type:
  - "null"
  - type: array
    items: string
  doc: Specify a single input file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 102
    prefix: --input-fmt-option
- id: records
  type:
  - "null"
  - int
  - string
  doc: Display INT alignment record lines
  inputBinding:
    position: 102
    prefix: --records
- id: reference
  type:
  - "null"
  - File
  doc: Reference sequence FASTA FILE
  inputBinding:
    position: 102
    prefix: --reference
- id: threads
  type:
  - "null"
  - int
  doc: Number of additional threads to use
  inputBinding:
    position: 102
    prefix: --threads
- id: verbosity
  type:
  - "null"
  - int
  doc: Set level of verbosity
  inputBinding:
    position: 102
    prefix: --verbosity
outputs:
- id: stdout
  type: stdout
  doc: Standard output
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
stdout: samtools_head.out
