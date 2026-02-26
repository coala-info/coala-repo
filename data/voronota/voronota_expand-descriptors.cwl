cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota_expand-descriptors
label: voronota_expand-descriptors
doc: "Expand atom descriptors to 'chainID resSeq iCode serial altLoc resName name'\n\
  \nTool homepage: https://www.voronota.com/"
inputs:
  - id: input_descriptors
    type: string
    doc: any text containing atom descriptors
    inputBinding:
      position: 1
outputs:
  - id: output_expanded_descriptors
    type: File
    doc: text with each atom descriptor expanded to 'chainID resSeq iCode serial
      altLoc resName name'
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
