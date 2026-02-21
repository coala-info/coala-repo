cwlVersion: v1.2
class: CommandLineTool
baseCommand: psmc
label: psmc
doc: "The provided text is a container build log and does not contain the help documentation
  for the psmc tool. As a result, no arguments could be extracted.\n\nTool homepage:
  https://github.com/lh3/psmc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psmc:0.6.5--h5ca1c30_4
stdout: psmc.out
