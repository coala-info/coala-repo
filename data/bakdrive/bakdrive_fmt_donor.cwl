cwlVersion: v1.2
class: CommandLineTool
baseCommand: bakdrive fmt_donor
label: bakdrive_fmt_donor
doc: "Input disease and donor sample file addresses\n\nTool homepage: https://gitlab.com/treangenlab/bakdrive"
inputs:
  - id: input_file
    type: File
    doc: Input disease and donor sample file addresses
    inputBinding:
      position: 1
  - id: medium
    type:
      - 'null'
      - File
    doc: Medium CSV file
    inputBinding:
      position: 102
      prefix: --medium
  - id: model
    type:
      - 'null'
      - string
    doc: Metabolic model database
    inputBinding:
      position: 102
      prefix: --model
  - id: percentage
    type:
      - 'null'
      - float
    doc: Percentage of species removed
    inputBinding:
      position: 102
      prefix: --percentage
  - id: strength
    type:
      - 'null'
      - float
    doc: Threshold of interaction strength
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
      - Directory
    doc: Output file folder
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bakdrive:1.0.4--hdfd78af_0
