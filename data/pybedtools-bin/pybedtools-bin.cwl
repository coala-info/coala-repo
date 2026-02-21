cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybedtools-bin
label: pybedtools-bin
doc: "The provided text does not contain help information; it is an error log from
  a container runtime (Apptainer/Singularity) failing to fetch or build the image.\n
  \nTool homepage: https://github.com/daler/pybedtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pybedtools-bin:v0.8.0-1-deb_cv1
stdout: pybedtools-bin.out
