cwlVersion: v1.2
class: CommandLineTool
baseCommand: easel
label: easel
doc: "The provided text does not contain help information for the tool 'easel'. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to pull the container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/EddyRivasLab/easel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/easel:0.49--hb6cb901_3
stdout: easel.out
