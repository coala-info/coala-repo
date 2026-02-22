cwlVersion: v1.2
class: CommandLineTool
baseCommand: brockman-pipeline
label: brockman-pipeline
doc: "The provided text does not contain help information or usage instructions; it
  consists of system error messages related to a failed container execution (Singularity/Apptainer)
  due to insufficient disk space.\n\nTool homepage: https://github.com/Carldeboer/Brockman"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/brockman-pipeline:1.0--1
stdout: brockman-pipeline.out
