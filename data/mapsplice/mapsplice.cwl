cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapsplice
label: mapsplice
doc: "MapSplice is a tool for mapping RNA-seq reads to a reference genome. (Note:
  The provided text is a container runtime error log and does not contain usage instructions
  or argument definitions).\n\nTool homepage: http://www.netlab.uky.edu/p/bioinfo/MapSplice2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapsplice:2.2.1--py39hc2f06e3_2
stdout: mapsplice.out
