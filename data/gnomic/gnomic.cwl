cwlVersion: v1.2
class: CommandLineTool
baseCommand: gnomic
label: gnomic
doc: "The provided text does not contain help information for the tool 'gnomic'. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to pull or build the container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/biosustain/gnomic"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gnomic:1.0.1--py_0
stdout: gnomic.out
