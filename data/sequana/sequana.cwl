cwlVersion: v1.2
class: CommandLineTool
baseCommand: sequana
label: sequana
doc: "A bioinformatics pipeline framework based on Snakemake\n\nTool homepage: https://sequana.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana:0.19.6--pyhdfd78af_0
stdout: sequana.out
