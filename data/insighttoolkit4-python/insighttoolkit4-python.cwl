cwlVersion: v1.2
class: CommandLineTool
baseCommand: insighttoolkit4-python
label: insighttoolkit4-python
doc: The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding disk space during a container build
  process.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/insighttoolkit4-python:v4.12.2-dfsg1-4b1-deb_cv1
stdout: insighttoolkit4-python.out
