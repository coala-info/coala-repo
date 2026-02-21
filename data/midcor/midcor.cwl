cwlVersion: v1.2
class: CommandLineTool
baseCommand: midcor
label: midcor
doc: "Mass Isotopomer Distribution (MID) correction tool (Note: The provided help
  text contains system error messages and does not list specific command-line arguments).\n
  \nTool homepage: https://github.com/Sainne/sainne-midcore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/midcor:phenomenal-v1.0_cv1.0.55
stdout: midcor.out
