cwlVersion: v1.2
class: CommandLineTool
baseCommand: anndata2ri
label: anndata2ri
doc: "A Python package for converting between AnnData (Python) and SingleCellExperiment
  (R) objects. Note: The provided text appears to be a container build error log rather
  than CLI help documentation.\n\nTool homepage: https://github.com/theislab/anndata2ri"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anndata2ri:2.0--pyhdfd78af_0
stdout: anndata2ri.out
