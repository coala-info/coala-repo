cwlVersion: v1.2
class: CommandLineTool
baseCommand: kerneltree
label: kerneltree
doc: "The provided text does not contain help information for kerneltree; it contains
  error logs from a container runtime failure (Apptainer/Singularity) indicating a
  'no space left on device' error during image conversion.\n\nTool homepage: https://pypi.org/project/kerneltree/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kerneltree:0.0.5--py39h38f01e4_1
stdout: kerneltree.out
