cwlVersion: v1.2
class: CommandLineTool
baseCommand: orthodb
label: orthodb
doc: "Note: The provided text is an error log from a container runtime (Apptainer/Singularity)
  rather than help documentation. It indicates a failure to build the SIF format from
  the docker image quay.io/biocontainers/orthodb due to insufficient disk space.\n
  \nTool homepage: https://www.ezlab.org/orthodb_v12_userguide.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orthodb:0.9.1--pyhdfd78af_0
stdout: orthodb.out
