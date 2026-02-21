cwlVersion: v1.2
class: CommandLineTool
baseCommand: s4pred
label: s4pred
doc: "A tool for protein secondary structure prediction (Note: The provided text appears
  to be a container build log rather than help text; no arguments could be extracted
  from the input).\n\nTool homepage: https://github.com/psipred/s4pred"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/s4pred:1.2.1--pyhdfd78af_1
stdout: s4pred.out
