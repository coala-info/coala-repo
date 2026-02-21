cwlVersion: v1.2
class: CommandLineTool
baseCommand: liana
label: liana
doc: "LIANA is a framework for ligand-receptor interaction analysis. (Note: The provided
  text contains a container runtime error and does not list specific command-line
  arguments.)\n\nTool homepage: https://liana-py.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/liana:1.7.1--pyhdfd78af_0
stdout: liana.out
