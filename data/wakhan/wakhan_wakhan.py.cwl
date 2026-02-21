cwlVersion: v1.2
class: CommandLineTool
baseCommand: wakhan_wakhan.py
label: wakhan_wakhan.py
doc: "The provided text contains container build logs and error messages rather than
  the help documentation for wakhan_wakhan.py. As a result, no arguments or tool descriptions
  could be extracted.\n\nTool homepage: https://github.com/KolmogorovLab/Wakhan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wakhan:0.2.0--pyhdfd78af_1
stdout: wakhan_wakhan.py.out
