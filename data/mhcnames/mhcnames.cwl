cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhcnames
label: mhcnames
doc: "A tool for parsing and normalizing MHC (Major Histocompatibility Complex) nomenclature.\n
  \nTool homepage: https://github.com/hammerlab/mhcnames"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhcnames:0.4.8--py_0
stdout: mhcnames.out
