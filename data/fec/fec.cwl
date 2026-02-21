cwlVersion: v1.2
class: CommandLineTool
baseCommand: fec
label: fec
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log regarding a container runtime failure.\n\nTool homepage:
  https://github.com/zhangjuncsu/Fec"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fec:1.0.1--he70b90d_2
stdout: fec.out
