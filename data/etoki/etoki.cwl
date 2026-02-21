cwlVersion: v1.2
class: CommandLineTool
baseCommand: etoki
label: etoki
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: https://github.com/zheminzhou/EToKi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/etoki:1.2.3--hdfd78af_0
stdout: etoki.out
