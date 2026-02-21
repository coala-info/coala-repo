cwlVersion: v1.2
class: CommandLineTool
baseCommand: im2deep
label: im2deep
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime (Apptainer/Singularity)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/compomics/im2deep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/im2deep:1.2.0--pyhdfd78af_0
stdout: im2deep.out
