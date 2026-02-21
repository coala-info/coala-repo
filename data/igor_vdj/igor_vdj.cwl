cwlVersion: v1.2
class: CommandLineTool
baseCommand: igor
label: igor_vdj
doc: "The provided text does not contain help information or usage instructions. It
  consists of system error messages related to a failed container image build (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://github.com/qmarcou/IGoR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/igor:v1.3.0dfsg-1-deb_cv1
stdout: igor_vdj.out
