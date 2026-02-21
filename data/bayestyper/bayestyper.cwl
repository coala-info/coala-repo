cwlVersion: v1.2
class: CommandLineTool
baseCommand: bayestyper
label: bayestyper
doc: "BayesTyper is a tool for genotyping variants (including SNPs, indels, and structural
  variants) using local assembly and k-mer counting. Note: The provided help text
  contains only system error logs and does not list specific command-line arguments.\n
  \nTool homepage: https://github.com/bioinformatics-centre/BayesTyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayestyper:1.5--hdcf5f25_3
stdout: bayestyper.out
