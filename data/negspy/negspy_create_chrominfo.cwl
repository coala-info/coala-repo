cwlVersion: v1.2
class: CommandLineTool
baseCommand: [create_chrominfo.py]
label: negspy_create_chrominfo
doc: "Create a chromInfo file (sequence name and length per line) for a genome FASTA
  file (plain or gzipped).\n\nTool homepage: https://github.com/pkerpedjiev/negspy"
inputs:
  - id: fasta_file
    type: File
    doc: Genome FASTA file (optionally gzipped).
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Tab-separated chromInfo table.
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/negspy:0.2.24--pyh7e72e81_0
stdout: negspy_create_chrominfo.out
