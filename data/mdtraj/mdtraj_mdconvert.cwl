cwlVersion: v1.2
class: CommandLineTool
baseCommand: mdconvert
label: mdtraj_mdconvert
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build a SIF image due to insufficient disk space.\n\nTool homepage:
  https://github.com/mdtraj/mdtraj"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mdtraj:1.9.9
stdout: mdtraj_mdconvert.out
