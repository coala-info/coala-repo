cwlVersion: v1.2
class: CommandLineTool
baseCommand: translig
label: translig
doc: "A de novo transcriptome assembler for seedling plants and other organisms.\n
  \nTool homepage: https://sourceforge.net/projects/transcriptomeassembly/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/translig:1.3--h56fc30b_0
stdout: translig.out
