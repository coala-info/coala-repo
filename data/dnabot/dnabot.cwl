cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnabot
label: dnabot
doc: "DNAbot: a tool for automated DNA assembly design and execution.\n\nTool homepage:
  https://github.com/Imperial-iGEM/Django-DNABOT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnabot:3.1.0
stdout: dnabot.out
