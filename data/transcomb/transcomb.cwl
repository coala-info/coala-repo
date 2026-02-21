cwlVersion: v1.2
class: CommandLineTool
baseCommand: transcomb
label: transcomb
doc: "TransComb is a genome-guided transcriptome assembler. Note: The provided text
  is a system error log regarding a container build failure and does not contain CLI
  usage information or arguments.\n\nTool homepage: https://github.com/movingpictures83/TransComb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transcomb:1.0--boost1.60_0
stdout: transcomb.out
