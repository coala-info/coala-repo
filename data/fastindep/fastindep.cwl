cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastindep
label: fastindep
doc: "Must specify datafile and parameter input file\n\nTool homepage: https://github.com/endrebak/fastindep"
inputs:
  - id: datafile
    type: File
    doc: datafile
    inputBinding:
      position: 1
  - id: parameter_input_file
    type: File
    doc: parameter input file
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastindep:1.0.0--h9948957_7
stdout: fastindep.out
