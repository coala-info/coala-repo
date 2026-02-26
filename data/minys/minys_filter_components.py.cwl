cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter_components.py
label: minys_filter_components.py
doc: "Filters components based on minimum length.\n\nTool homepage: https://github.com/cguyomar/MinYS"
inputs:
  - id: infile
    type: File
    doc: Input file
    inputBinding:
      position: 1
  - id: minlength
    type: int
    doc: Minimum length of components to keep
    inputBinding:
      position: 2
outputs:
  - id: outfile
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minys:1.1--hc9558a2_1
