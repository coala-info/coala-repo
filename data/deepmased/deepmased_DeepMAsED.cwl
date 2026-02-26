cwlVersion: v1.2
class: CommandLineTool
baseCommand: DeepMAsED
label: deepmased_DeepMAsED
doc: "Deep learning for Metagenome Assembly Error Detection\n\nTool homepage: https://github.com/leylabmpi/DeepMAsED"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run (train, predict, evaluate, features)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmased:0.3.1--pyh5ca1d4c_0
stdout: deepmased_DeepMAsED.out
