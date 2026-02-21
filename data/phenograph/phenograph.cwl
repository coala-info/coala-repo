cwlVersion: v1.2
class: CommandLineTool
baseCommand: phenograph
label: phenograph
doc: "PhenoGraph is a method for clustering high-dimensional single-cell data. (Note:
  The provided input text consists of system logs and error messages regarding a container
  build failure and does not contain CLI usage instructions or argument definitions.)\n
  \nTool homepage: https://github.com/dpeerlab/PhenoGraph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phenograph:1.5.7--pyhdfd78af_0
stdout: phenograph.out
