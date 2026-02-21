cwlVersion: v1.2
class: CommandLineTool
baseCommand: naf
label: naf
doc: "Nucleotide Archival Format (NAF) tool (Note: The provided text is a system error
  message and does not contain help information or argument definitions).\n\nTool
  homepage: https://github.com/KirillKryukov/naf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/naf:1.3.0--h7b50bb2_5
stdout: naf.out
