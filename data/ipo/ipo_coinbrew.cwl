cwlVersion: v1.2
class: CommandLineTool
baseCommand: ipo_coinbrew
label: ipo_coinbrew
doc: "Isotopologue Parameter Optimization (Note: The provided text appears to be a
  container execution error log rather than help documentation, so no arguments could
  be extracted).\n\nTool homepage: https://github.com/coin-or/Ipopt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ipo:v1.7.5_cv0.3
stdout: ipo_coinbrew.out
