cwlVersion: v1.2
class: CommandLineTool
baseCommand: bakdrive_fmt_only
label: bakdrive_fmt_only
doc: "Format input files for bakdrive.\n\nTool homepage: https://gitlab.com/treangenlab/bakdrive"
inputs:
  - id: input_file
    type: File
    doc: Input file prefix
    inputBinding:
      position: 1
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output file prefix
    inputBinding:
      position: 102
      prefix: --prefix
  - id: strength
    type:
      - 'null'
      - float
    doc: Threshold of Interaction Strength
    default: 0.2
    inputBinding:
      position: 102
      prefix: --strength
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file prefix
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bakdrive:1.0.4--hdfd78af_0
