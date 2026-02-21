cwlVersion: v1.2
class: CommandLineTool
baseCommand: surpyvor
label: surpyvor
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch the surpyvor image.\n\nTool homepage: https://github.com/wdecoster/surpyvor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
stdout: surpyvor.out
