cwlVersion: v1.2
class: CommandLineTool
baseCommand: mutalyzer_hgvs_parser
label: mutalyzer_hgvs_parser
doc: "A tool for parsing HGVS (Human Genome Variation Society) variant descriptions.
  (Note: The provided input text contains system error messages regarding container
  execution and does not list specific command-line arguments.)\n\nTool homepage:
  The package home page"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mutalyzer_hgvs_parser:0.3.9--pyh7e72e81_0
stdout: mutalyzer_hgvs_parser.out
