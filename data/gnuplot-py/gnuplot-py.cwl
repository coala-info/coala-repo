cwlVersion: v1.2
class: CommandLineTool
baseCommand: gnuplot-py
label: gnuplot-py
doc: "A Python interface to the gnuplot plotting program. (Note: The provided help
  text contains only system error messages regarding container execution and does
  not list specific command-line arguments.)\n\nTool homepage: https://github.com/CNTRUN/Termux-command"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gnuplot-py:1.8--pyhdc42f0e_2
stdout: gnuplot-py.out
