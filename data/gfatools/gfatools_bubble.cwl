cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfatools bubble
label: gfatools_bubble
doc: "Extract bubbles from a GFA graph.\n\nTool homepage: https://github.com/lh3/gfatools"
inputs:
  - id: in_gfa
    type: File
    doc: Input GFA file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfatools:0.5.5--h577a1d6_0
stdout: gfatools_bubble.out
