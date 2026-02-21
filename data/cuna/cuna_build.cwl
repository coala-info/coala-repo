cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cuna
  - build
label: cuna_build
doc: "Build or convert OCI images to SIF format\n\nTool homepage: https://github.com/iris1901/CUNA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cuna:0.3.0--pyhdfd78af_0
stdout: cuna_build.out
