cwlVersion: v1.2
class: CommandLineTool
baseCommand: biosquid
label: biosquid
doc: 'No description available: The provided text is a system error log regarding
  container image acquisition, not help text.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biosquid:v1.9gcvs20050121-11-deb_cv1
stdout: biosquid.out
