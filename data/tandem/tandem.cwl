cwlVersion: v1.2
class: CommandLineTool
baseCommand: tandem
label: tandem
doc: "TANDEM Alanine (2017.2.1.4)\n\nTool homepage: https://github.com/tum-vision/tandem"
inputs:
  - id: filename
    type: File
    doc: any valid path to an XML input file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tandem:v17-02-01-4_cv4
stdout: tandem.out
