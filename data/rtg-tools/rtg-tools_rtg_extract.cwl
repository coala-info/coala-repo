cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - extract
label: rtg-tools_rtg_extract
doc: 'Extract records from an indexed genomic position data file. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: file
    type: File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: 'the indexed block compressed genome position data file to extract'
    inputBinding:
      position: 200
  - id: region
    type:
      - 'null'
      - type: array
        items: string
    doc: 'the range to display. The format is one of <sequence_name>, <sequence_name>:<start>-<end>, <sequence_name>:<pos>+<length> or <sequence_name>:<pos>~<padding>. May be specified 0 or more times'
    inputBinding:
      position: 201
  - id: header
    type:
      - 'null'
      - boolean
    doc: 'print out header also'
    inputBinding:
      position: 101
      prefix: --header
  - id: header_only
    type:
      - 'null'
      - boolean
    doc: 'print out header only'
    inputBinding:
      position: 101
      prefix: --header-only
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_extract.out
