cwlVersion: v1.2
class: CommandLineTool
baseCommand: hippunfold
label: hippunfold
doc: "The provided text is an error log from a container runtime and does not contain
  help information or argument definitions for the tool.\n\nTool homepage: https://github.com/khanlab/hippunfold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hippunfold:2.0.0--pyh7e72e81_0
stdout: hippunfold.out
