cwlVersion: v1.2
class: CommandLineTool
baseCommand: daisysuite
label: daisysuite
doc: "A tool for the analysis of differentially abundant isoforms in simulated and
  real data (Note: The provided text contains system error logs rather than help documentation,
  so specific arguments could not be extracted).\n\nTool homepage: https://gitlab.com/eseiler/DaisySuite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/daisysuite:1.3.0--hdfd78af_3
stdout: daisysuite.out
