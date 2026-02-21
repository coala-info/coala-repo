cwlVersion: v1.2
class: CommandLineTool
baseCommand: expam_CountUniqueKmers.py
label: expam_CountUniqueKmers.py
doc: "Count unique kmers (Note: The provided help text contains only system error
  logs and no usage information).\n\nTool homepage: https://github.com/seansolari/expam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
stdout: expam_CountUniqueKmers.py.out
