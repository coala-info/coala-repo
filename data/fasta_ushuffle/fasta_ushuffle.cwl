cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta_ushuffle
label: fasta_ushuffle
doc: "A tool for shuffling FASTA sequences while preserving k-mer frequency. Note:
  The provided help text contains only system error messages regarding a container
  runtime failure and does not list specific command-line arguments.\n\nTool homepage:
  https://github.com/agordon/fasta_ushuffle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasta_ushuffle:0.2--hec16e2b_4
stdout: fasta_ushuffle.out
