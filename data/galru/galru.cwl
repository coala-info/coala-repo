cwlVersion: v1.2
class: CommandLineTool
baseCommand: galru
label: galru
doc: "The provided text does not contain help information for the tool 'galru'. It
  contains error logs related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/quadram-institute-bioscience/galru"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galru:1.0.0--py_0
stdout: galru.out
