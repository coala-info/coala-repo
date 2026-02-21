cwlVersion: v1.2
class: CommandLineTool
baseCommand: secapr
label: secapr
doc: "Sequence Capture Processor (Note: The provided input text contains container
  build error logs rather than the tool's help documentation. No arguments could be
  extracted.)\n\nTool homepage: https://github.com/AntonelliLab/seqcap_processor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
stdout: secapr.out
