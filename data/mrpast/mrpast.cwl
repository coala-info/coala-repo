cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrpast
label: mrpast
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to insufficient disk space.\n\nTool
  homepage: https://aprilweilab.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
stdout: mrpast.out
