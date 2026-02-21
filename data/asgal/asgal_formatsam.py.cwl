cwlVersion: v1.2
class: CommandLineTool
baseCommand: asgal_formatsam.py
label: asgal_formatsam.py
doc: "A tool for formatting SAM files, part of the ASGAL (Alternative Splicing Graph
  Aligner) suite. Note: The provided help text contains only system error messages
  regarding container image extraction and does not list specific command-line arguments.\n
  \nTool homepage: https://asgal.algolab.eu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/asgal:1.1.8--h5ca1c30_2
stdout: asgal_formatsam.py.out
