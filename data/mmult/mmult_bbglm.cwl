cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmult_bbglm
label: mmult_bbglm
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  image acquisition.\n\nTool homepage: https://github.com/lijinbio/MMULT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmult:0.0.0.2--r40h8b68381_0
stdout: mmult_bbglm.out
