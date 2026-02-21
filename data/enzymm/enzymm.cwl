cwlVersion: v1.2
class: CommandLineTool
baseCommand: enzymm
label: enzymm
doc: "The provided text is an error log from a container runtime and does not contain
  help information or usage instructions for the 'enzymm' tool. As a result, no arguments
  could be extracted.\n\nTool homepage: https://pypi.org/project/enzymm/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enzymm:0.3.1--pyhdfd78af_0
stdout: enzymm.out
