cwlVersion: v1.2
class: CommandLineTool
baseCommand: GapCloser
label: soapdenovo2-gapcloser
doc: GapCloser is a tool designed to close gaps emerging from the scaffolding process
  of SOAPdenovo or other assemblers.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soapdenovo2-gapcloser:1.12--h077b44d_3
stdout: soapdenovo2-gapcloser.out
