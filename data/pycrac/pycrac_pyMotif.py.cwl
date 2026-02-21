cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyMotif.py
label: pycrac_pyMotif.py
doc: "A tool from the pyCRAC package. Note: The provided text appears to be a container
  engine error log rather than the tool's help documentation, so no arguments could
  be extracted.\n\nTool homepage: http://sandergranneman.bio.ed.ac.uk/Granneman_Lab/pyCRAC_software.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycrac:1.5.2--pyh7cba7a3_0
stdout: pycrac_pyMotif.py.out
