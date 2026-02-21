cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycrac_pyReadAligner.py
label: pycrac_pyReadAligner.py
doc: "A tool from the pyCRAC package. (Note: The provided text contains container
  build logs and error messages rather than the tool's help documentation, so no arguments
  could be extracted.)\n\nTool homepage: http://sandergranneman.bio.ed.ac.uk/Granneman_Lab/pyCRAC_software.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycrac:1.5.2--pyh7cba7a3_0
stdout: pycrac_pyReadAligner.py.out
