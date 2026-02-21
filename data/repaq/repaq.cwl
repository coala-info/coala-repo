cwlVersion: v1.2
class: CommandLineTool
baseCommand: repaq
label: repaq
doc: "A tool for FASTQ data compression and decompression (Note: The provided text
  is a container build log and does not contain help documentation; no arguments could
  be parsed from the input).\n\nTool homepage: https://github.com/OpenGene/repaq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repaq:0.5.1--hcb620b3_1
stdout: repaq.out
