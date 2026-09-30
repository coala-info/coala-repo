cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chromosomer
  - fragmentmapbed
label: chromosomer_fragmentmapbed
doc: "Convert a fragment map to the BED format.\n\nTool homepage: https://github.com/gtamazian/chromosomer"
inputs:
  - id: map
    type: File
    doc: a fragment map file
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: an output BED file representing the fragment map
    inputBinding:
      position: 2
outputs:
  - id: out_output
    type: File
    doc: an output BED file representing the fragment map
    outputBinding:
      glob: '$(inputs.output)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromosomer:0.1.4a--py27_1
