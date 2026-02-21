cwlVersion: v1.2
class: CommandLineTool
baseCommand: dodge
label: dodge
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a set of error logs from a container runtime (Apptainer/Singularity)
  failing to pull or build the image due to insufficient disk space.\n\nTool homepage:
  https://github.com/LanLab/dodge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dodge:1.0.1--pyhdfd78af_0
stdout: dodge.out
