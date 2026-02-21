cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntlink
label: ntlink
doc: "ntLink is a tool for scaffolding assembly contigs using long reads.\n\nTool
  homepage: https://github.com/bcgsc/ntLink"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntlink:1.3.11--py312h7896c42_1
stdout: ntlink.out
