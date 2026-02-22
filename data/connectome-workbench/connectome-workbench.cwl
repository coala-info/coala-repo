cwlVersion: v1.2
class: CommandLineTool
baseCommand: connectome-workbench
label: connectome-workbench
doc: "The provided text contains system error messages and logs related to a container
  image build failure (no space left on device) rather than the command-line interface
  help documentation for the tool.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
stdout: connectome-workbench.out
