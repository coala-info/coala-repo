cwlVersion: v1.2
class: CommandLineTool
baseCommand: soapdenovo2-errorcorrection
label: soapdenovo2-errorcorrection
doc: 'A tool for error correction in SOAPdenovo2 (Note: The provided help text contains
  only container execution errors and no usage information).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soapdenovo2-errorcorrection:2.0--h077b44d_9
stdout: soapdenovo2-errorcorrection.out
