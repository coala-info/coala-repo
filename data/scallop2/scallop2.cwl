cwlVersion: v1.2
class: CommandLineTool
baseCommand: scallop2
label: scallop2
doc: "Scallop2 is a transcript assembler for RNA-seq data. (Note: The provided input
  text contained only container build errors and no help documentation to parse.)\n
  \nTool homepage: https://github.com/Shao-Group/scallop2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scallop2:1.1.2--h5ca1c30_8
stdout: scallop2.out
