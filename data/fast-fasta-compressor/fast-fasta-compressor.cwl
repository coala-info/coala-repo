cwlVersion: v1.2
class: CommandLineTool
baseCommand: fast-fasta-compressor
label: fast-fasta-compressor
doc: "A tool for fast FASTA compression (Note: The provided help text contains only
  container runtime error logs and does not list specific command-line arguments).\n
  \nTool homepage: https://github.com/kowallus/ffc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast-fasta-compressor:1.0--h9948957_0
stdout: fast-fasta-compressor.out
