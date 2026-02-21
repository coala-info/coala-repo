cwlVersion: v1.2
class: CommandLineTool
baseCommand: crossmap
label: crossmap
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failing to pull
  or build the image due to insufficient disk space ('no space left on device').\n
  \nTool homepage: https://crossmap.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
stdout: crossmap.out
