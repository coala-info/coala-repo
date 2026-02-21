cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-find-clusters.r
label: seurat-scripts_seurat-find-clusters.r
doc: "The provided text is an error log indicating a failure to build or run the container
  (no space left on device) and does not contain the help text or argument definitions
  for the tool.\n\nTool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
stdout: seurat-scripts_seurat-find-clusters.r.out
