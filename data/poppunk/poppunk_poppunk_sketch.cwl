cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - poppunk
  - --sketch
label: poppunk_poppunk_sketch
doc: "PopPUNK (Population Partitioning Using Nucleotide K-mers) sketching utility.
  Note: The provided help text contains only system error logs and does not list specific
  command-line arguments.\n\nTool homepage: https://github.com/johnlees/PopPUNK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poppunk:2.7.8--py310h4d0eb5b_0
stdout: poppunk_poppunk_sketch.out
