cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastagap_degap_fasta_alignment.pl
label: fastagap_degap_fasta_alignment.pl
doc: "A tool to remove gaps from a FASTA alignment.\n\nTool homepage: https://github.com/nylander/fastagap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastagap:1.0.1--hdfd78af_0
stdout: fastagap_degap_fasta_alignment.pl.out
