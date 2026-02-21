cwlVersion: v1.2
class: CommandLineTool
baseCommand: kodoja_kodoja_retrieve.py
label: kodoja_kodoja_retrieve.py
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to lack of disk space.\n\nTool homepage: https://github.com/abaizan/kodoja/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kodoja:0.0.10--0
stdout: kodoja_kodoja_retrieve.py.out
