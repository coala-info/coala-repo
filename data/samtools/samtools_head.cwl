cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- head
label: samtools_head
doc: 'Show the header and the first records of an alignment file


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: input_file
  type:
  - 'null'
  - File
  doc: Input SAM/BAM/CRAM file.
  inputBinding:
    position: 104
- id: headers
  type:
  - 'null'
  - int
  doc: Display INT header lines [all].
  inputBinding:
    position: 103
    prefix: --headers
- id: records
  type:
  - 'null'
  - int
  doc: Display INT alignment record lines [none].
  inputBinding:
    position: 103
    prefix: --records
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
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional threads to use [0].
  inputBinding:
    position: 103
    prefix: --threads
- id: verbosity
  type:
  - 'null'
  - int
  doc: Set level of verbosity.
  inputBinding:
    position: 103
    prefix: --verbosity
outputs:
- id: output
  type: stdout
  doc: Header and record lines.
stdout: head.txt
