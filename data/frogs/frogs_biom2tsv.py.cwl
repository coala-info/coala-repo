cwlVersion: v1.2
class: CommandLineTool
baseCommand: frogs_biom2tsv.py
label: frogs_biom2tsv.py
doc: "A tool to convert BIOM files to TSV format (Note: The provided help text contained
  only execution errors and no argument definitions).\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: frogs_biom2tsv.py.out
