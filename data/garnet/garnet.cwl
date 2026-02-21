cwlVersion: v1.2
class: CommandLineTool
baseCommand: garnet
label: garnet
doc: "The provided text contains system log errors and does not include the help documentation
  for the tool. No arguments could be extracted.\n\nTool homepage: https://github.com/fraenkel-lab/GarNet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/garnet:0.4.5--py35_0
stdout: garnet.out
