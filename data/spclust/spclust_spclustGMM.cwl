cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spclust
  - spclustGMM
label: spclust_spclustGMM
doc: "Spatial clustering using Gaussian Mixture Models. (Note: The provided text contains
  container build logs rather than tool help text; no arguments could be extracted.)\n
  \nTool homepage: https://github.com/johnymatar/SpCLUST/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spclust:28.5.19--h425c490_1
stdout: spclust_spclustGMM.out
