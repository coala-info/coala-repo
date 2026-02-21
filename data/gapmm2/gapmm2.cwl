cwlVersion: v1.2
class: CommandLineTool
baseCommand: gapmm2
label: gapmm2
doc: "The provided text does not contain help information or usage instructions. It
  contains error messages related to a container environment (Apptainer/Singularity)
  failing to pull or build the image due to insufficient disk space.\n\nTool homepage:
  https://github.com/nextgenusfs/gapmm2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gapmm2:25.8.12--pyhdfd78af_0
stdout: gapmm2.out
