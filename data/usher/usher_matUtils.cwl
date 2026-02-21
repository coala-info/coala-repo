cwlVersion: v1.2
class: CommandLineTool
baseCommand: matUtils
label: usher_matUtils
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch or build the UShER container image.\n\nTool homepage: https://github.com/yatisht/usher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/usher:0.6.6--h719ac0c_1
stdout: usher_matUtils.out
