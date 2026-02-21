cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssake_TQSfastq.py
label: ssake_TQSfastq.py
doc: "The provided text does not contain help information for ssake_TQSfastq.py; it
  is a log of a failed container build/fetch process.\n\nTool homepage: https://github.com/warrenlr/SSAKE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ssake:v4.0-2-deb_cv1
stdout: ssake_TQSfastq.py.out
