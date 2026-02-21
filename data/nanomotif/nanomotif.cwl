cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanomotif
label: nanomotif
doc: "The provided text does not contain help information or usage instructions. It
  is an error log from a container runtime (Singularity/Apptainer) indicating a failure
  to build the image due to insufficient disk space.\n\nTool homepage: https://pypi.org/project/nanomotif/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanomotif:1.1.2--pyhdfd78af_0
stdout: nanomotif.out
