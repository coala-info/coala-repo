cwlVersion: v1.2
class: CommandLineTool
baseCommand: gencove
label: gencove
doc: "The provided text does not contain help information for the gencove tool. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build a SIF image due to lack of disk space.\n\nTool homepage: https://docs.gencove.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gencove:4.2.0--pyhdfd78af_0
stdout: gencove.out
