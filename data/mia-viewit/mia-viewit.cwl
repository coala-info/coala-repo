cwlVersion: v1.2
class: CommandLineTool
baseCommand: mia-viewit
label: mia-viewit
doc: The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding a container
  build failure (no space left on device).
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mia-viewit:v1.0.5-2-deb_cv1
stdout: mia-viewit.out
