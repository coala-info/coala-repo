cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqnado
label: seqnado
doc: "The provided text is a system error log regarding a container build failure
  ('no space left on device') and does not contain the help text or usage instructions
  for the tool. As a result, no arguments could be extracted.\n\nTool homepage: https://alsmith151.github.io/SeqNado/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqnado:0.7.6--pyhdfd78af_0
stdout: seqnado.out
