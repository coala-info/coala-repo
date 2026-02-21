cwlVersion: v1.2
class: CommandLineTool
baseCommand: keepalive
label: keepalive
doc: "A tool to keep connections or processes alive (Note: The provided text contains
  system error logs rather than help documentation, so specific arguments could not
  be identified).\n\nTool homepage: https://github.com/acassen/keepalived"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/keepalive:0.5--py36_0
stdout: keepalive.out
