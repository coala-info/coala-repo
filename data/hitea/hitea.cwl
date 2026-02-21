cwlVersion: v1.2
class: CommandLineTool
baseCommand: hitea
label: hitea
doc: "Hi-C Transposable Element Analyzer (Note: The provided text contains container
  runtime error logs rather than tool help text, so arguments could not be extracted).\n
  \nTool homepage: https://github.com/parklab/HiTea"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hitea:0.1.5--hdfd78af_1
stdout: hitea.out
