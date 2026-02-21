cwlVersion: v1.2
class: CommandLineTool
baseCommand: prefersim_GetListOfRunsWhereFrequencyMatches.pl
label: prefersim_GetListOfRunsWhereFrequencyMatches.pl
doc: "A script to get a list of runs where frequency matches. (Note: The provided
  help text contains container execution errors and does not list specific arguments
  or usage instructions.)\n\nTool homepage: https://github.com/LohmuellerLab/PReFerSim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prefersim:1.0--h940b034_4
stdout: prefersim_GetListOfRunsWhereFrequencyMatches.pl.out
