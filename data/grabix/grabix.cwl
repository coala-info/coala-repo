cwlVersion: v1.2
class: CommandLineTool
baseCommand: grabix
label: grabix
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to lack of disk space.\n\nTool homepage:
  https://github.com/arq5x/grabix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grabix:0.1.8--h077b44d_12
stdout: grabix.out
