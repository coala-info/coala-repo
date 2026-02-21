cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffc
label: fast-fasta-compressor_ffc
doc: "A tool for fast FASTA file compression. Note: The provided text contains system
  error logs rather than help documentation, so specific arguments could not be extracted.\n
  \nTool homepage: https://github.com/kowallus/ffc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast-fasta-compressor:1.0--h9948957_0
stdout: fast-fasta-compressor_ffc.out
