cwlVersion: v1.2
class: CommandLineTool
baseCommand: swipe
label: swipe
doc: "SWIPE is a tool for performing rapid Smith-Waterman database searches using
  SIMD parallel computing technology.\n\nTool homepage: http://dna.uio.no/swipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/swipe:2.1.1--hf1d56f0_5
stdout: swipe.out
