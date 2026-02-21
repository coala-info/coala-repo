cwlVersion: v1.2
class: CommandLineTool
baseCommand: edlib
label: edlib
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  pull the edlib image due to insufficient disk space.\n\nTool homepage: https://github.com/Martinsos/edlib/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/edlib:v1.2.4-1-deb-py3_cv1
stdout: edlib.out
