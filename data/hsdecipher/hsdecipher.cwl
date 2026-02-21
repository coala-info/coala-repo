cwlVersion: v1.2
class: CommandLineTool
baseCommand: hsdecipher
label: hsdecipher
doc: "A tool for deciphering haplo-signatures (Note: The provided text is an error
  log and does not contain functional descriptions or argument details).\n\nTool homepage:
  https://github.com/zx0223winner/HSDecipher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hsdecipher:1.1.2--hdfd78af_0
stdout: hsdecipher.out
