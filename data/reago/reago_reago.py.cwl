cwlVersion: v1.2
class: CommandLineTool
baseCommand: reago_reago.py
label: reago_reago.py
doc: "REconstruct 16S ribosomal RNA genes from metagenomic data. (Note: The provided
  help text contains only environment info and a fatal error message, so no arguments
  could be extracted from the source text.)\n\nTool homepage: https://github.com/chengyuan/reago-1.1"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reago:1.1--py35_0
stdout: reago_reago.py.out
