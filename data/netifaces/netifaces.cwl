cwlVersion: v1.2
class: CommandLineTool
baseCommand: netifaces
label: netifaces
doc: "The provided text does not contain help information for the 'netifaces' tool.
  It appears to be an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build a SIF image due to insufficient disk space.\n\nTool homepage:
  https://github.com/al45tair/netifaces"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/netifaces:0.10.4--py36_1
stdout: netifaces.out
