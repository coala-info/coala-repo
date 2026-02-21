cwlVersion: v1.2
class: CommandLineTool
baseCommand: ale_ale2wiggle.py
label: ale_ale2wiggle.py
doc: "A tool to convert ALE (Assembly Likelihood Evaluation) output to Wiggle format.
  Note: The provided help text contains only system error logs and does not list specific
  arguments.\n\nTool homepage: https://github.com/sc932/ALE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ale:20180904--py27ha92aebf_0
stdout: ale_ale2wiggle.py.out
