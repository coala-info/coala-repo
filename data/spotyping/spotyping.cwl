cwlVersion: v1.2
class: CommandLineTool
baseCommand: spotyping
label: spotyping
doc: "SpoTyping: fast and accurate in silico Mycobacterium tuberculosis spacer oligonucleotide
  typing\n\nTool homepage: https://github.com/xiaeryu/SpoTyping-v2.0"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spotyping:2.1--py27_0
stdout: spotyping.out
