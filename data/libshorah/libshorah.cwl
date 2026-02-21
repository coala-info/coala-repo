cwlVersion: v1.2
class: CommandLineTool
baseCommand: libshorah
label: libshorah
doc: "The provided text does not contain help information or a description of the
  tool. It is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the SIF format due to lack of disk space.\n\nTool homepage: https://github.com/LaraFuhrmann/VILOCA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libshorah:1.99.4--py38hebc1f04_1
stdout: libshorah.out
