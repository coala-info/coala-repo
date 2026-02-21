cwlVersion: v1.2
class: CommandLineTool
baseCommand: zifa
label: zifa
doc: "Zero-Inflated Factor Analysis (ZIFA) for dimensionality reduction of sparse
  single-cell RNA-seq data.\n\nTool homepage: https://github.com/epierson9/ZIFA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zifa:0.1.0--py36_0
stdout: zifa.out
