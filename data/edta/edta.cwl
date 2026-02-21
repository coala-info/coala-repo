cwlVersion: v1.2
class: CommandLineTool
baseCommand: edta
label: edta
doc: "Extensive de-novo TE Annotator (Note: The provided text contains error logs
  rather than help documentation, so no arguments could be parsed).\n\nTool homepage:
  https://github.com/oushujun/EDTA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/edta:2.2.2--hdfd78af_1
stdout: edta.out
