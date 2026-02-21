cwlVersion: v1.2
class: CommandLineTool
baseCommand: sashimi-py
label: sashimi-py
doc: "A tool for visualizing RNA-seq data (Note: The provided input text contains
  system error logs rather than the tool's help documentation).\n\nTool homepage:
  https://github.com/ygidtu/sashimi.py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sashimi-py:0.1.5--pyh7cba7a3_0
stdout: sashimi-py.out
