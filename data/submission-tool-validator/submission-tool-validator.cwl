cwlVersion: v1.2
class: CommandLineTool
baseCommand: submission-tool-validator
label: submission-tool-validator
doc: "A tool for validating submissions (Note: The provided text contains log output
  rather than help documentation, so specific arguments could not be parsed).\n\n
  Tool homepage: https://github.com/bigbio/submission-tool-validator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/submission-tool-validator:1.0.7--hdfd78af_0
stdout: submission-tool-validator.out
