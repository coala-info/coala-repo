cwlVersion: v1.2
class: CommandLineTool
baseCommand: edentity
label: edentity
doc: "The provided text does not contain help information for the tool 'edentity'.
  It contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to insufficient disk space.\n\nTool homepage:
  https://pypi.org/project/edentity/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/edentity:1.5.4--pyhdfd78af_0
stdout: edentity.out
