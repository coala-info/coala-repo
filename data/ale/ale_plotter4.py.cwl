cwlVersion: v1.2
class: CommandLineTool
baseCommand: ale_plotter4.py
label: ale_plotter4.py
doc: "ALE plotter tool (Note: The provided text is a system error log and does not
  contain help or usage information for the tool).\n\nTool homepage: https://github.com/sc932/ALE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ale:20180904--py27ha92aebf_0
stdout: ale_plotter4.py.out
