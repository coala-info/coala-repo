cwlVersion: v1.2
class: CommandLineTool
baseCommand: cyushuffle
label: cyushuffle
doc: "A tool for shuffling sequences (description not available in provided text)\n
  \nTool homepage: https://github.com/guma44/ushuffle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cyushuffle:1.1.2--py39hbcbf7aa_7
stdout: cyushuffle.out
