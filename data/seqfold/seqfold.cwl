cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqfold
label: seqfold
doc: "The provided text is a system error log indicating a failure to build or run
  the container image (no space left on device) and does not contain help documentation
  or argument definitions for the tool 'seqfold'.\n\nTool homepage: https://github.com/Lattice-Automation/seqfold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfold:0.9.0--pyhdfd78af_0
stdout: seqfold.out
