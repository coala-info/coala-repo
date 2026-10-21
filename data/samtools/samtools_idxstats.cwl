cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- idxstats
label: samtools_idxstats
doc: 'Print BAM index statistics


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: in_bam
  type: File
  doc: Indexed input BAM/CRAM file.
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
- id: customized_index
  type:
  - 'null'
  - boolean
  doc: Include customized index file.
  inputBinding:
    position: 103
    prefix: -X
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
  doc: Per-reference length, mapped and unmapped read counts.
stdout: idxstats.txt
