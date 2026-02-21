cwlVersion: v1.2
class: CommandLineTool
baseCommand: xs-sim
label: xs-sim_XS
doc: "A tool for cross-sectional simulation (Note: The provided help text contains
  only container runtime error messages and no usage information).\n\nTool homepage:
  https://github.com/pratas/xs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xs-sim:2--h7b50bb2_3
stdout: xs-sim_XS.out
