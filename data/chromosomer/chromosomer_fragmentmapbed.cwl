cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromosomer fragmentmapbed
label: chromosomer_fragmentmapbed
doc: "Convert a fragment map to the BED format.\n\nTool homepage: https://github.com/gtamazian/chromosomer"
inputs:
  - id: map
    type: File
    doc: a fragment map file
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    doc: an output BED file representing the fragment map
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromosomer:0.1.4a--py27_1
