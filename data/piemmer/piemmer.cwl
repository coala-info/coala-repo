cwlVersion: v1.2
class: CommandLineTool
baseCommand: piemmer
label: piemmer
doc: "The provided text contains system error messages regarding container image retrieval
  and disk space limitations rather than the tool's help documentation. Consequently,
  no functional arguments or tool descriptions could be extracted.\n\nTool homepage:
  The package home page"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/piemmer:1.0.5--pyhfa5458b_0
stdout: piemmer.out
