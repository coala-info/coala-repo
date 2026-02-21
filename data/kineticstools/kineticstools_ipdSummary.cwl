cwlVersion: v1.2
class: CommandLineTool
baseCommand: ipdSummary
label: kineticstools_ipdSummary
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container execution (no space left
  on device).\n\nTool homepage: https://github.com/PacificBiosciences/kineticsTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/kineticstools:v0.6.120161222-1-deb-py2_cv1
stdout: kineticstools_ipdSummary.out
