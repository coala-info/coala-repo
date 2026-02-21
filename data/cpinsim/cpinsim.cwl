cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpinsim
label: cpinsim
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is a log of a failed container build process (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://github.com/BiancaStoecker/cpinsim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpinsim:0.5.2--py36_1
stdout: cpinsim.out
