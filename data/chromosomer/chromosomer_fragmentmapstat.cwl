cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromosomer fragmentmapstat
label: chromosomer_fragmentmapstat
doc: "Show statistics on a fragment map.\n\nTool homepage: https://github.com/gtamazian/chromosomer"
inputs:
  - id: map
    type: File
    doc: a fragment map file
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    doc: an output file of fragment map statistics
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromosomer:0.1.4a--py27_1
