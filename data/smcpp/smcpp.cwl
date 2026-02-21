cwlVersion: v1.2
class: CommandLineTool
baseCommand: smcpp
label: smcpp
doc: "SMC++: Statistical inference of population size history from whole-genome sequence
  data. (Note: The provided text is a container build error log and does not contain
  help documentation or argument definitions.)\n\nTool homepage: https://github.com/popgenmethods/smcpp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smcpp:1.15.4--py39hac1eaed_0
stdout: smcpp.out
