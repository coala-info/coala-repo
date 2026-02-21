cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrtrix3
label: mrtrix3
doc: "The provided text does not contain help information for mrtrix3; it contains
  error messages related to a container runtime (Singularity/Apptainer) failing to
  pull the image due to insufficient disk space.\n\nTool homepage: https://www.mrtrix.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
stdout: mrtrix3.out
