cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlpy
label: mlpy
doc: "mlpy is a Python module for Machine Learning built on top of NumPy/SciPy and
  the GNU Scientific Library.\n\nTool homepage: http://mlpy.sourceforge.net/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mlpy:3.5.0--py36h6bb024c_0
stdout: mlpy.out
