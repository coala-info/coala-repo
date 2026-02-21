cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq2HLA.py
label: seq2hla
doc: "HLA typing from RNA-Seq data\n\nTool homepage: https://github.com/TRON-Bioinformatics/seq2HLA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq2hla:2.3--hdfd78af_1
stdout: seq2hla.out
