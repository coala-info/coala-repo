cwlVersion: v1.2
class: CommandLineTool
baseCommand: npyscreen
label: npyscreen
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the SIF format due to insufficient disk space.\n\nTool homepage:
  http://www.npcole.com/npyscreen/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/npyscreen:5.0.2--pyh7e72e81_0
stdout: npyscreen.out
