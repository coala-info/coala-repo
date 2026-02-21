cwlVersion: v1.2
class: CommandLineTool
baseCommand: nucmer
label: mummer_nucmer
doc: "The provided text contains container runtime error messages and does not include
  the help documentation for the tool. No arguments could be extracted.\n\nTool homepage:
  https://github.com/mummer4/mummer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321h503566f_21
stdout: mummer_nucmer.out
