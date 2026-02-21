cwlVersion: v1.2
class: CommandLineTool
baseCommand: foldcomp
label: foldcomp
doc: "The provided text does not contain help information for foldcomp; it contains
  error logs related to a container runtime (Apptainer/Singularity) failure due to
  insufficient disk space.\n\nTool homepage: https://github.com/steineggerlab/foldcomp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/foldcomp:0.1.0--h5ca1c30_0
stdout: foldcomp.out
