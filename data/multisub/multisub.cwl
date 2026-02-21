cwlVersion: v1.2
class: CommandLineTool
baseCommand: multisub
label: multisub
doc: "The provided text does not contain help information for the tool 'multisub'.
  It consists of error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build or pull the container image due to lack of disk space.\n\nTool
  homepage: https://github.com/maximilianh/multiSub"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multisub:1.0.0--pyh5e36f6f_0
stdout: multisub.out
