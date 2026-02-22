cwlVersion: v1.2
class: CommandLineTool
baseCommand: blaze2
label: blaze2
doc: "Barcode Identification from Nanopore Reads (Note: The provided text contains
  error logs rather than help documentation; no arguments could be extracted from
  the input).\n\nTool homepage: https://github.com/shimlab/BLAZE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blaze2:2.5.1--pyhdfd78af_0
stdout: blaze2.out
