cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmcif
label: mmcif
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to pull or build the container image due to insufficient disk space.\n\nTool homepage:
  http://mmcif.wwpdb.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmcif:1.1.0--py310h8ea774a_0
stdout: mmcif.out
