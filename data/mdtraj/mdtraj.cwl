cwlVersion: v1.2
class: CommandLineTool
baseCommand: mdtraj
label: mdtraj
doc: "The provided text does not contain help information for mdtraj; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the image due to lack of disk space.\n\nTool homepage: https://github.com/mdtraj/mdtraj"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mdtraj:1.9.9
stdout: mdtraj.out
