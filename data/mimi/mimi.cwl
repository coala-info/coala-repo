cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimi
label: mimi
doc: "Metagenomic Identification of MIcrobes (Note: The provided text contains container
  runtime error logs rather than tool help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/NYUAD-Core-Bioinformatics/MIMI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimi:1.0.4--pyhdfd78af_0
stdout: mimi.out
