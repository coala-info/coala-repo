cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgpyo
label: fgpyo
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: https://pypi.org/project/fgpyo/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgpyo:1.4.0--pyhdfd78af_0
stdout: fgpyo.out
