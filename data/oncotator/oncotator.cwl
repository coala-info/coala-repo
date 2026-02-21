cwlVersion: v1.2
class: CommandLineTool
baseCommand: oncotator
label: oncotator
doc: "The provided text does not contain help information; it is an error log from
  a container runtime (Apptainer/Singularity) indicating a failure to pull the image
  due to insufficient disk space.\n\nTool homepage: https://github.com/broadinstitute/oncotator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oncotator:1.9.9.0--py_0
stdout: oncotator.out
