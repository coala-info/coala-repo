cwlVersion: v1.2
class: CommandLineTool
baseCommand: dDocent
label: ddocent
doc: "dDocent is an interactive pipeline for processing RADseq data. (Note: The provided
  help text contains only system error messages regarding container image creation
  and does not list specific command-line arguments).\n\nTool homepage: https://ddocent.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ddocent:2.9.8--hdfd78af_0
stdout: ddocent.out
