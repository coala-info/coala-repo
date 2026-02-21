cwlVersion: v1.2
class: CommandLineTool
baseCommand: carp-extract
label: carp_carp-extract
doc: "C-based Automated Repeat Parser (extract utility)\n\nTool homepage: https://github.com/gi-bielefeld/scj-carp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/carp:0.1.1--h4349ce8_0
stdout: carp_carp-extract.out
