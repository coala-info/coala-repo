cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastspar
label: fastspar
doc: "FastSpar is a C++ implementation of the SparCC algorithm for estimating correlations
  in compositional data. (Note: The provided input text contains system error messages
  regarding container image conversion and does not contain the actual help documentation
  for the tool.)\n\nTool homepage: https://github.com/scwatts/fastspar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastspar:1.0.0--h1b620e3_6
stdout: fastspar.out
