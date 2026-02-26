cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./mstmap.exe
label: mstmap
doc: "Map reads to a reference genome.\n\nTool homepage: http://mstmap.org/"
inputs:
  - id: input_file
    type: File
    doc: Input file containing reads
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type: File
    doc: Output file for mapped reads
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mstmap:1--h4ac6f70_3
