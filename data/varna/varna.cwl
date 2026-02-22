cwlVersion: v1.2
class: CommandLineTool
baseCommand: varna
label: varna
doc: "The provided text does not contain help information for the tool 'varna'. It
  consists of system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull or build an image due to insufficient disk space.\n\nTool homepage:
  https://github.com/pwwang/python-varname"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/varna:v3-93ds-2-deb_cv1
stdout: varna.out
