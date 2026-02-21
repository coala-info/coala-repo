cwlVersion: v1.2
class: CommandLineTool
baseCommand: genbank_genbank.py
label: genbank_genbank.py
doc: "A tool for processing GenBank files. (Note: The provided help text contains
  system error messages regarding container execution and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/deprekate/genbank"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genbank:0.121--py313h366bbf7_1
stdout: genbank_genbank.py.out
