cwlVersion: v1.2
class: CommandLineTool
baseCommand: profphd
label: profphd
doc: The provided text does not contain help information or usage instructions for
  the tool 'profphd'. It appears to be a container runtime error log.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/profphd:v1.0.42-3-deb_cv1
stdout: profphd.out
