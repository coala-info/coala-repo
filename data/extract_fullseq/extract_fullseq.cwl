cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract_fullseq
label: extract_fullseq
doc: 'Extract full sequences (Note: The provided text contains container runtime error
  messages and does not include usage instructions or argument definitions).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/extract_fullseq:3.101--h9948957_6
stdout: extract_fullseq.out
