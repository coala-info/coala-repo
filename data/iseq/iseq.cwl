cwlVersion: v1.2
class: CommandLineTool
baseCommand: iseq
label: iseq
doc: "The provided text is a container runtime error log and does not contain help
  information or argument definitions for the tool 'iseq'.\n\nTool homepage: https://github.com/BioOmics/iSeq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iseq:1.9.8--hdfd78af_0
stdout: iseq.out
