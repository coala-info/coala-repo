cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnadiff
label: mummer4_dnadiff
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull or build the image due to insufficient disk space.\n\nTool homepage: https://mummer4.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4_dnadiff.out
