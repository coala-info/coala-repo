cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bustools
  - cite
label: bustools_cite
doc: "Display citation information for bustools\n\nTool homepage: https://github.com/BUStools/bustools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
stdout: bustools_cite.out
