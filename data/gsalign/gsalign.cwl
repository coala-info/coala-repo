cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsalign
label: gsalign
doc: "A tool for genome alignment (Note: The provided text contains system error messages
  rather than help documentation, so specific arguments could not be extracted).\n
  \nTool homepage: https://github.com/hsinnan75/GSAlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsalign:1.0.22--hcb620b3_8
stdout: gsalign.out
