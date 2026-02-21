cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfatools
label: gfatools
doc: "No description available from the provided error log.\n\nTool homepage: https://github.com/lh3/gfatools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfatools:0.5.5--h577a1d6_0
stdout: gfatools.out
