cwlVersion: v1.2
class: CommandLineTool
baseCommand: TANmask
label: damasker_TANmask
doc: "The provided text does not contain help information or documentation for the
  tool. It contains system error logs related to a container runtime (Apptainer/Singularity)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/thegenemyers/DAMASKER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/damasker:1.0p1--h7b50bb2_8
stdout: damasker_TANmask.out
