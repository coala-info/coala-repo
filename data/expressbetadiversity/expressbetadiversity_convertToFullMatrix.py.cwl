cwlVersion: v1.2
class: CommandLineTool
baseCommand: convertToFullMatrix.py
label: expressbetadiversity_convertToFullMatrix.py
doc: "Convert Phylip lower-triangular matrix produced by EBD to full matrix.\n\nTool
  homepage: https://github.com/dparks1134/ExpressBetaDiversity"
inputs:
  - id: input_matrix
    type: File
    doc: Dissimilarity matrix produced by EBD.
    inputBinding:
      position: 1
outputs:
  - id: output_matrix
    type: File
    doc: Output full dissimilarity matrix.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expressbetadiversity:1.0.10--h9948957_6
