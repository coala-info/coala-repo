cwlVersion: v1.2
class: CommandLineTool
baseCommand: mobyle-programs
label: mobyle-programs
doc: The provided text does not contain help information or usage instructions. It
  consists of system log messages and a fatal error regarding insufficient disk space
  during a container image conversion.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mobyle-programs:v5.1.2-3-deb_cv1
stdout: mobyle-programs.out
