cwlVersion: v1.2
class: CommandLineTool
baseCommand: mia
label: mia
doc: "The provided text does not contain help documentation for the tool 'mia'. It
  consists of error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build a SIF image due to insufficient disk space.\n\nTool homepage:
  https://github.com/qiurunze123/miaosha"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mia:v0.1.9-1-deb-py3_cv1
stdout: mia.out
