cwlVersion: v1.2
class: CommandLineTool
baseCommand: pathogist
label: pathogist
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime (Singularity/Apptainer)
  failing to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/WGS-TB/PathOGiST"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathogist:0.3.6--py_0
stdout: pathogist.out
