cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastremap-bio
label: fastremap-bio
doc: "A tool for remapping sequences (description not available in provided text)\n
  \nTool homepage: https://github.com/CMU-SAFARI/FastRemap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastremap-bio:1.0.0--hdcf5f25_1
stdout: fastremap-bio.out
