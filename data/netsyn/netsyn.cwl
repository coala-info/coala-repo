cwlVersion: v1.2
class: CommandLineTool
baseCommand: netsyn
label: netsyn
doc: "The provided text does not contain help information for the tool 'netsyn'. It
  contains error messages from a container runtime (Apptainer/Singularity) indicating
  a failure to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/labgem/netsyn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/netsyn:1.0.0--pyh7e72e81_0
stdout: netsyn.out
