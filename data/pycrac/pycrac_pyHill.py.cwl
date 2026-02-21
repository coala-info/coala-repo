cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycrac_pyHill.py
label: pycrac_pyHill.py
doc: "The provided text does not contain help information for pycrac_pyHill.py; it
  is a container runtime error log.\n\nTool homepage: http://sandergranneman.bio.ed.ac.uk/Granneman_Lab/pyCRAC_software.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycrac:1.5.2--pyh7cba7a3_0
stdout: pycrac_pyHill.py.out
