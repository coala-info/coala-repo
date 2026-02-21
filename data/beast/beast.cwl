cwlVersion: v1.2
class: CommandLineTool
baseCommand: beast
label: beast
doc: "Bayesian Evolutionary Analysis Sampling Trees (Note: The provided text is a
  system error log and does not contain help documentation or argument definitions).\n
  \nTool homepage: https://beast.community"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beast:10.5.0--hdfd78af_0
stdout: beast.out
