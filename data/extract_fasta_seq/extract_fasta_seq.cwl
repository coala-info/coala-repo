cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract_fasta_seq
label: extract_fasta_seq
doc: "A tool to extract sequences from FASTA files (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/linzhi2013/extract_fasta_seq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/extract_fasta_seq:0.0.1--py_0
stdout: extract_fasta_seq.out
