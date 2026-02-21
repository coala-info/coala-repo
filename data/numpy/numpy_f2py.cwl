cwlVersion: v1.2
class: CommandLineTool
baseCommand: f2py
label: numpy_f2py
doc: "Fortran to Python interface generator\n\nTool homepage: https://github.com/numpy/numpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/numpy:2.2.2
stdout: numpy_f2py.out
