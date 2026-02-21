cwlVersion: v1.2
class: CommandLineTool
baseCommand: kopt
label: kopt
doc: "The provided text does not contain help information or a description for the
  tool 'kopt'. It contains error logs related to a container runtime (Apptainer/Singularity)
  failing to build a SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/avsecz/keras-hyperopt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kopt:0.1.0--pyh24bf2e0_0
stdout: kopt.out
