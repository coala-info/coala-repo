cwlVersion: v1.2
class: CommandLineTool
baseCommand: scprep
label: scprep
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log related to a failed Singularity/Docker image pull
  due to insufficient disk space.\n\nTool homepage: https://github.com/KrishnaswamyLab/scprep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scprep:1.2.3--pyhdfd78af_1
stdout: scprep.out
