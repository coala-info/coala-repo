cwlVersion: v1.2
class: CommandLineTool
baseCommand: wham
label: wham
doc: "Structural variant caller (Note: The provided text is a container execution
  error log and does not contain help documentation or argument definitions).\n\n
  Tool homepage: https://github.com/zeeev/wham"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wham:1.8.0.1.2017.05.03--hd28b015_0
stdout: wham.out
