cwlVersion: v1.2
class: CommandLineTool
baseCommand: jacusa2
label: jacusa2
doc: "JACUSA2 (Joint Analysis of Cleavage and Under-Sequencing Analysis). Note: The
  provided text is a container runtime error log and does not contain usage instructions
  or argument definitions.\n\nTool homepage: https://github.com/dieterich-lab/JACUSA2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jacusa2:2.1.16--hdfd78af_0
stdout: jacusa2.out
