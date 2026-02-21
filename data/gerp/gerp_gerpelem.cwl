cwlVersion: v1.2
class: CommandLineTool
baseCommand: gerp_gerpelem
label: gerp_gerpelem
doc: "GERP (Genomic Evolutionary Rate Profiling) tool for identifying constrained
  elements in multiple alignments. (Note: The provided help text contains system error
  messages regarding container execution and does not list specific command-line arguments).\n
  \nTool homepage: http://mendel.stanford.edu/SidowLab/downloads/gerp/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gerp:2.1--hfc679d8_0
stdout: gerp_gerpelem.out
