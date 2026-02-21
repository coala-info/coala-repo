cwlVersion: v1.2
class: CommandLineTool
baseCommand: ogstools
label: ogstools
doc: "The provided text does not contain help information for the tool. It consists
  of error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to pull or build the container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/ufz/ogstools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ogstools:0.4.0
stdout: ogstools.out
