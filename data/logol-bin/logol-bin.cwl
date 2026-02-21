cwlVersion: v1.2
class: CommandLineTool
baseCommand: logol-bin
label: logol-bin
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to lack of disk space.\n\nTool homepage: https://github.com/genouest/logol"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/logol-bin:v1.7.9-1-deb_cv1
stdout: logol-bin.out
