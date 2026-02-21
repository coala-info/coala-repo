cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanopolish_makerange.py
label: nanopolish_nanopolish_makerange.py
doc: "A helper script for nanopolish to generate genomic ranges for parallel processing.\n
  \nTool homepage: https://github.com/jts/nanopolish"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopolish:0.14.0--h5ca1c30_6
stdout: nanopolish_nanopolish_makerange.py.out
