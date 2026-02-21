cwlVersion: v1.2
class: CommandLineTool
baseCommand: dazzdb
label: dazzdb
doc: The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image creation (no space
  left on device).
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dazzdb:v1.020161112-2-deb_cv1
stdout: dazzdb.out
