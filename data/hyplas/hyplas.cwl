cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyplas
label: hyplas
doc: "The provided text does not contain help information for the tool 'hyplas'. It
  contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull the tool's image due to insufficient disk space.\n\nTool homepage:
  https://github.com/cchauve/hyplas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyplas:1.0.2--py311h2de2dd3_0
stdout: hyplas.out
