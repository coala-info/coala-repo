cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqsero2s
label: seqsero2s
doc: "The provided text is an error log from a container build process and does not
  contain help documentation or command-line arguments for seqsero2s.\n\nTool homepage:
  https://github.com/LSTUGA/SeqSero2S"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqsero2s:1.1.4--pyhdfd78af_1
stdout: seqsero2s.out
