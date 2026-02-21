cwlVersion: v1.2
class: CommandLineTool
baseCommand: nucamino
label: nucamino
doc: "A nucleotide to amino acid alignment tool (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/hivdb/nucamino"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nucamino:0.1.3--0
stdout: nucamino.out
