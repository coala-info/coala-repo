cwlVersion: v1.2
class: CommandLineTool
baseCommand: ma
label: ma
doc: "The provided text does not contain help information for the tool 'ma'. It appears
  to be a system error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build or pull the container image due to lack of disk space.\n\nTool
  homepage: https://github.com/ITBE-Lab/MA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ma:2.0.2--py37h595c7a6_0
stdout: ma.out
