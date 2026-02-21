cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycrac
label: pycrac
doc: "The provided text does not contain help information for the pycrac tool. It
  appears to be a fatal error log from a Singularity/Apptainer container build process.\n
  \nTool homepage: http://sandergranneman.bio.ed.ac.uk/Granneman_Lab/pyCRAC_software.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycrac:1.5.2--pyh7cba7a3_0
stdout: pycrac.out
