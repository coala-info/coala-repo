cwlVersion: v1.2
class: CommandLineTool
baseCommand: bakdrive driver
label: bakdrive_driver
doc: "Input folder of bacteria interaction networks\n\nTool homepage: https://gitlab.com/treangenlab/bakdrive"
inputs:
  - id: input_folder
    type: Directory
    doc: Input folder of bacteria interaction networks
    inputBinding:
      position: 1
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output file folder
    default: output_driver
    inputBinding:
      position: 102
      prefix: --output
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output file prefix
    default: driver_nodes
    inputBinding:
      position: 102
      prefix: --prefix
  - id: strength
    type:
      - 'null'
      - float
    doc: Threshold of interaction strength
    default: 0.2
    inputBinding:
      position: 102
      prefix: --strength
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bakdrive:1.0.4--hdfd78af_0
stdout: bakdrive_driver.out
