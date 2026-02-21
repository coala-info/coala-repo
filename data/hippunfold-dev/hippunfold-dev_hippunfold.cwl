cwlVersion: v1.2
class: CommandLineTool
baseCommand: hippunfold
label: hippunfold-dev_hippunfold
doc: "Automated hippocampal unfolding\n\nTool homepage: https://github.com/khanlab/hippunfold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hippunfold-dev:2.0.0--pyh7e72e81_0
stdout: hippunfold-dev_hippunfold.out
