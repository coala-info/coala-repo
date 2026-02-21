cwlVersion: v1.2
class: CommandLineTool
baseCommand: odil
label: odil
doc: "The provided text does not contain help information for the tool 'odil'. It
  appears to be an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to pull or convert a Docker image due to insufficient disk space.\n\n
  Tool homepage: https://github.com/odilia-app/odilia"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/odil:v0.10.0-3-deb-py3_cv1
stdout: odil.out
