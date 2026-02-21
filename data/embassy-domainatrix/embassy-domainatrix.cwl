cwlVersion: v1.2
class: CommandLineTool
baseCommand: domainatrix
label: embassy-domainatrix
doc: The provided text does not contain help information for the tool. It contains
  system error messages regarding container image conversion and disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/embassy-domainatrix:v0.1.660-3-deb_cv1
stdout: embassy-domainatrix.out
