cwlVersion: v1.2
class: CommandLineTool
baseCommand: genepender_appendgenecol.py
label: genepender_appendgenecol.py
doc: "A tool to append a gene column to a dataset (Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  arguments).\n\nTool homepage: https://github.com/BioTools-Tek/genepender"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genepender:v2.6--h470a237_1
stdout: genepender_appendgenecol.py.out
