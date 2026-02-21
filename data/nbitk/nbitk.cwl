cwlVersion: v1.2
class: CommandLineTool
baseCommand: nbitk
label: nbitk
doc: "The provided text contains container runtime logs and an error message rather
  than the tool's help documentation. No arguments or tool descriptions could be extracted.\n
  \nTool homepage: https://pypi.org/project/nbitk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nbitk:0.7.3--pyh1f0d9b5_0
stdout: nbitk.out
