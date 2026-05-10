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
    inputBinding:
      position: 102
      prefix: --strength
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file prefix
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bakdrive:1.0.4--hdfd78af_0
