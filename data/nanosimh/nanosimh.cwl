cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanosimh
label: nanosimh
doc: 'A nanopore read simulator (Note: The provided text is a container runtime error
  message and does not contain usage information or argument definitions).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanosimh:v1.0.1.8--py34r3.3.1_1
stdout: nanosimh.out
