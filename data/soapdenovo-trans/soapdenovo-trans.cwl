cwlVersion: v1.2
class: CommandLineTool
baseCommand: soapdenovo-trans
label: soapdenovo-trans
doc: "A transcriptome assembler for very short reads. (Note: The provided input text
  contains container engine error logs and does not include the tool's help documentation;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/Viktor1117/SOAPdenovoTrans"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soapdenovo-trans:1.04--h577a1d6_7
stdout: soapdenovo-trans.out
