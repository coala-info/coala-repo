cwlVersion: v1.2
class: CommandLineTool
baseCommand: reago_filter_input.py
label: reago_filter_input.py
doc: "A tool for filtering input data for REAGO (REconstruct 16S ribosomal RNA Genes
  from Metagenomic data). Note: The provided text contains container runtime error
  messages rather than the tool's help documentation.\n\nTool homepage: https://github.com/chengyuan/reago-1.1"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reago:1.1--py35_0
stdout: reago_filter_input.py.out
