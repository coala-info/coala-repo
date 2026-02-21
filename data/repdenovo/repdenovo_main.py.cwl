cwlVersion: v1.2
class: CommandLineTool
baseCommand: repdenovo_main.py
label: repdenovo_main.py
doc: "A tool for de novo repeat discovery. (Note: The provided help text contains
  container execution errors and does not list specific command-line arguments.)\n
  \nTool homepage: https://github.com/Reedwarbler/REPdenovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repdenovo:0.0.1--h26b121b_5
stdout: repdenovo_main.py.out
