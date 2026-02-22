cwlVersion: v1.2
class: CommandLineTool
baseCommand: scater-scripts
label: scater-scripts
doc: "The provided text does not contain help information or usage instructions. It
  contains system error messages related to a lack of disk space during a Singularity/Docker
  container build process.\n\nTool homepage: https://github.com/ebi-gene-expression-group/bioconductor-scater-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scater-scripts:0.0.5--0
stdout: scater-scripts.out
