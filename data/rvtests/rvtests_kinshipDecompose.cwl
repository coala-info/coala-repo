cwlVersion: v1.2
class: CommandLineTool
baseCommand: [kinshipDecompose]
label: rvtests_kinshipDecompose
doc: "Spectral decomposition of a kinship matrix (eigenvalues and eigenvectors).\n\nTool homepage: https://github.com/zhanxw/rvtests"
inputs:
  - id: in
    type: File
    doc: "Input kinship file"
    inputBinding:
      position: 101
      prefix: --in
  - id: out
    type: string
    default: decomposed
    doc: "Output prefix for autosomal kinship calculation"
    inputBinding:
      position: 101
      prefix: --out
outputs:
  - id: eigen
    type: File
    doc: "Eigen decomposition of the kinship matrix (IID, Lambda, U1..Un)"
    outputBinding:
      glob: "$(inputs.out).eigen"
  - id: out_log
    type: File
    doc: "Log file"
    outputBinding:
      glob: "$(inputs.out).kinshipDecompose.log"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
