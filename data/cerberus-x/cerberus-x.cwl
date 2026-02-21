cwlVersion: v1.2
class: CommandLineTool
baseCommand: cerberus-x
label: cerberus-x
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process (Apptainer/Singularity) due
  to insufficient disk space.\n\nTool homepage: https://github.com/raw-lab/cerberus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cerberus-x:1.5.0--pyhdfd78af_0
stdout: cerberus-x.out
