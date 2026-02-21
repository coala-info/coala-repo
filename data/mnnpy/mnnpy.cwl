cwlVersion: v1.2
class: CommandLineTool
baseCommand: mnnpy
label: mnnpy
doc: "MNN (Mutual Nearest Neighbors) correction for batch effect removal in single-cell
  RNA-seq data.\n\nTool homepage: http://github.com/chriscainx/mnnpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mnnpy:0.1.9.5--py39hf95cd2a_8
stdout: mnnpy.out
