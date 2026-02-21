cwlVersion: v1.2
class: CommandLineTool
baseCommand: SiprosV4OMP
label: sipros_SiprosV4OMP
doc: "Sipros is a database searching tool for protein identification. (Note: The provided
  text contained system logs rather than help documentation; no arguments could be
  extracted from the input.)\n\nTool homepage: https://github.com/thepanlab/Sipros4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sipros:5.0.1--hdfd78af_1
stdout: sipros_SiprosV4OMP.out
