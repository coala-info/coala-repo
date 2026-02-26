cwlVersion: v1.2
class: CommandLineTool
baseCommand: dinf_check
label: dinf_check
doc: "Basic dinf_model health checks.\n\nChecks that the target and generator functions
  work and return the\nsame feature shapes and dtypes.\n\nTool homepage: https://github.com/RacimoLab/dinf"
inputs:
  - id: model
    type: File
    doc: "Python script from which to import the variable\n\"dinf_model\". This is
      a dinf.DinfModel object that\ndescribes the model components. See the examples/\n\
      folder of the git repository for example models.\nhttps://github.com/RacimoLab/dinf"
    default: model.py
    inputBinding:
      position: 101
      prefix: --model
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Disable output. Only ERROR and CRITICAL messages are\nprinted."
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase verbosity. Specify once for INFO messages and\ntwice for DEBUG
      messages."
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dinf:0.5.0--pyhdfd78af_0
stdout: dinf_check.out
