cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepac convert
label: deepac_convert
doc: "Convert a trained deepac model to a format suitable for inference.\n\nTool homepage:
  https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: config
    type: File
    doc: Training config file.
    inputBinding:
      position: 1
  - id: model
    type: File
    doc: Saved model.
    inputBinding:
      position: 2
  - id: init
    type:
      - 'null'
      - boolean
    doc: Initialize a random model from config.
    inputBinding:
      position: 103
      prefix: --init
  - id: weights
    type:
      - 'null'
      - boolean
    doc: Use prepared weights instead of the model file.
    inputBinding:
      position: 103
      prefix: --weights
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
stdout: deepac_convert.out
