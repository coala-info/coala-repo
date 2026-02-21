cwlVersion: v1.2
class: CommandLineTool
baseCommand: TETyper.py
label: tetyper_TETyper.py
doc: "A tool for identifying and typing transposable elements (TETyper). Note: The
  provided help text contains only system error logs and does not list command-line
  arguments.\n\nTool homepage: https://github.com/aesheppard/TETyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tetyper:1.1--0
stdout: tetyper_TETyper.py.out
