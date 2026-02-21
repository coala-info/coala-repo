cwlVersion: v1.2
class: CommandLineTool
baseCommand: nucmer
label: mummer4_nucmer
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log from a container runtime (Apptainer/Singularity) indicating
  a failure to pull the mummer4 container image due to lack of disk space.\n\nTool
  homepage: https://mummer4.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4_nucmer.out
