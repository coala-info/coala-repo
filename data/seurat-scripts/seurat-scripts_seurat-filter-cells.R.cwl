cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-filter-cells.R
label: seurat-scripts_seurat-filter-cells.R
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build/execution due to insufficient disk space
  ('no space left on device').\n\nTool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
stdout: seurat-scripts_seurat-filter-cells.R.out
