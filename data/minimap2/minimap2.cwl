cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimap2
label: minimap2
doc: "The provided text does not contain help information or usage instructions. It
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build the container image due to insufficient disk space ('no space left on device').\n
  \nTool homepage: https://github.com/lh3/minimap2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minimap2:2.30--h577a1d6_0
stdout: minimap2.out
