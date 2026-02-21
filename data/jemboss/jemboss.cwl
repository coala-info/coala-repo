cwlVersion: v1.2
class: CommandLineTool
baseCommand: jemboss
label: jemboss
doc: The provided text does not contain help information or usage instructions. It
  consists of system log messages indicating a fatal error during a container build
  process (no space left on device).
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jemboss:v6.6.0dfsg-7-deb_cv1
stdout: jemboss.out
