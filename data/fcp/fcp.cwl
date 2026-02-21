cwlVersion: v1.2
class: CommandLineTool
baseCommand: fcp
label: fcp
doc: "The provided text does not contain help information for the tool 'fcp'. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/Svetlitski/fcp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fcp:1.0.7--py27_0
stdout: fcp.out
