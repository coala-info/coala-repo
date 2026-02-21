cwlVersion: v1.2
class: CommandLineTool
baseCommand: vartrix
label: vartrix
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a container runtime error log.\n\nTool homepage: https://github.com/10XGenomics/vartrix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vartrix:1.1.22--h9ee0642_6
stdout: vartrix.out
