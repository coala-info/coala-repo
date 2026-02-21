cwlVersion: v1.2
class: CommandLineTool
baseCommand: manormfast
label: manormfast
doc: "The provided text does not contain help information for manormfast; it contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/semal/MAnormFast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/manormfast:0.1.2--py36_1
stdout: manormfast.out
