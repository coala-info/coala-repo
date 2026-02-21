cwlVersion: v1.2
class: CommandLineTool
baseCommand: geco3_GeDe3
label: geco3_GeDe3
doc: "A tool for genomic data compression (Note: The provided text appears to be a
  container runtime error log rather than help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/cobilab/geco3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/geco3:1.0--h7b50bb2_5
stdout: geco3_GeDe3.out
