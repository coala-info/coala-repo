cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-find-neighbours.R
label: seurat-scripts_seurat-find-neighbours.R
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or extract a Singularity/Apptainer container due
  to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
stdout: seurat-scripts_seurat-find-neighbours.R.out
