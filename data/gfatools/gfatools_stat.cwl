cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfatools_stat
label: gfatools_stat
doc: "Print statistics about a GFA file.\n\nTool homepage: https://github.com/lh3/gfatools"
inputs:
  - id: input_gfa
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
stdout: gfatools_stat.out
