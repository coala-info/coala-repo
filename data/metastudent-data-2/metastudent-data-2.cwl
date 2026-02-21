cwlVersion: v1.2
class: CommandLineTool
baseCommand: metastudent-data-2
label: metastudent-data-2
doc: 'Data package for Metastudent. Note: The provided text contains container runtime
  error messages rather than command-line help documentation.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/metastudent-data-2:v1.0.0-4-deb_cv1
stdout: metastudent-data-2.out
