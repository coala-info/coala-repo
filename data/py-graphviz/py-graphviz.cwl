cwlVersion: v1.2
class: CommandLineTool
baseCommand: py-graphviz
label: py-graphviz
doc: "The provided text contains container build logs and error messages rather than
  command-line help documentation. No arguments or tool descriptions could be extracted.\n
  \nTool homepage: https://github.com/CNTRUN/Termux-command"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/py-graphviz:0.4.10--py35_0
stdout: py-graphviz.out
