cwlVersion: v1.2
class: CommandLineTool
baseCommand: deeptools
label: deeptools
doc: "The provided text does not contain help information or usage instructions. It
  contains system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull the deepTools image due to lack of disk space.\n\nTool homepage:
  https://github.com/deeptools/deepTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deeptools:3.5.6--pyhdfd78af_0
stdout: deeptools.out
