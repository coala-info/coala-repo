cwlVersion: v1.2
class: CommandLineTool
baseCommand: DeepMicroClass
label: deepmicroclass_DeepMicroClass
doc: "A deep learning framework for classifying metagenomic sequences\n\nTool homepage:
  https://github.com/chengsly/DeepMicroClass"
inputs:
  - id: mode
    type: string
    doc: 'Subcommand to run: test, train, or predict'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmicroclass:1.0.3--pyhdfd78af_1
stdout: deepmicroclass_DeepMicroClass.out
