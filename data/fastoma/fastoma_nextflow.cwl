cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastoma_nextflow
label: fastoma_nextflow
doc: "The provided text does not contain help information for the tool; it contains
  system log messages and a fatal error regarding container image creation (no space
  left on device).\n\nTool homepage: https://github.com/DessimozLab/FastOMA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastoma:0.5.1--pyhdfd78af_0
stdout: fastoma_nextflow.out
