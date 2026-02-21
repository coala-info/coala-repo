cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta-splitter.pl
label: fasta-splitter_fasta-splitter.pl
doc: "A tool to split FASTA files into smaller chunks. (Note: The provided help text
  contains a system error and does not list specific arguments.)\n\nTool homepage:
  http://kirill-kryukov.com/study/tools/fasta-splitter/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasta-splitter:0.2.6--0
stdout: fasta-splitter_fasta-splitter.pl.out
