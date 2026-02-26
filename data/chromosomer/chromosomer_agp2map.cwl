cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chromosomer
  - agp2map
label: chromosomer_agp2map
doc: "Convert an AGP file to the fragment map format.\n\nTool homepage: https://github.com/gtamazian/chromosomer"
inputs:
  - id: agp_file
    type: File
    doc: an AGP file
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type: File
    doc: the output fragment map file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromosomer:0.1.4a--py27_1
