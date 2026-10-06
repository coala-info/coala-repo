cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bakdrive
  - driver
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
      - string
    doc: Output file folder
    inputBinding:
      position: 102
      prefix: --output
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
    doc: Threshold of interaction strength
    inputBinding:
      position: 102
      prefix: --strength
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: driver_nodes
    type:
      type: array
      items: File
    doc: List of identified driver species (<prefix>.<N>layer.str<S>.txt)
    outputBinding:
      glob: $(inputs.output || 'output_driver')/$(inputs.prefix || 'driver_nodes').*
  - id: output_dir
    type: Directory
    doc: Output file folder
    outputBinding:
      glob: $(inputs.output || 'output_driver')
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bakdrive:1.0.4--hdfd78af_0
stdout: bakdrive_driver.out
