cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - submission-tool-validator.jar
label: submission-tool-validator_submission-tool-validator.jar
doc: "A tool for validating submission metadata or tool definitions.\n\nTool homepage:
  https://github.com/bigbio/submission-tool-validator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/submission-tool-validator:1.0.7--hdfd78af_0
stdout: submission-tool-validator_submission-tool-validator.jar.out
