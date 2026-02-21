cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnalyze
label: rnalyze
doc: "A tool for RNA analysis (Note: The provided text appears to be a container build
  log rather than help text, so no arguments could be extracted).\n\nTool homepage:
  https://github.com/MohamedElsisii/rnalyze"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnalyze:1.0.1--hdfd78af_1
stdout: rnalyze.out
