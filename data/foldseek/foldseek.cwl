cwlVersion: v1.2
class: CommandLineTool
baseCommand: foldseek
label: foldseek
doc: "The provided text does not contain help information for foldseek. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull or build the image due to lack of disk space.\n\nTool homepage: https://github.com/steineggerlab/foldseek"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/foldseek:10.941cd33--h5021889_1
stdout: foldseek.out
