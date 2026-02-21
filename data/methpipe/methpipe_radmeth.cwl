cwlVersion: v1.2
class: CommandLineTool
baseCommand: radmeth
label: methpipe_radmeth
doc: "The provided text does not contain help information for methpipe_radmeth. It
  contains system error logs regarding a container runtime (Apptainer/Singularity)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/smithlabcode/methpipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methpipe:5.0.1--h76b9af2_6
stdout: methpipe_radmeth.out
