cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - DeepMicroClass
  - train
label: deepmicroclass_train
doc: "Train the model\n\nTool homepage: https://github.com/chengsly/DeepMicroClass"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Path to the input fasta file
    inputBinding:
      position: 101
      prefix: --input
  - id: log_prefix
    type:
      - 'null'
      - string
    doc: Prefix for the log directory
    inputBinding:
      position: 101
      prefix: --log_prefix
outputs:
  - id: logs
    type:
      - 'null'
      - Directory
    doc: Training log directory
    outputBinding:
      glob: '$(inputs.log_prefix ? inputs.log_prefix : "log")'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmicroclass:1.0.3--pyhdfd78af_1
