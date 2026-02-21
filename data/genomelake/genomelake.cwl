cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomelake
label: genomelake
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/kundajelab/genomelake"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomelake:0.1.5--py27h516909a_0
stdout: genomelake.out
