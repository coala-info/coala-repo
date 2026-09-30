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
  - id: output_file
    type: string
    doc: the output fragment map file
    inputBinding:
      position: 2
outputs:
  - id: out_output_file
    type: File
    doc: the output fragment map file
    outputBinding:
      glob: '$(inputs.output_file)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromosomer:0.1.4a--py27_1
