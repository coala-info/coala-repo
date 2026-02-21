cwlVersion: v1.2
class: CommandLineTool
baseCommand: lap
label: lap
doc: "The provided text does not contain help information or usage instructions; it
  contains system log messages and a fatal error regarding container execution.\n\n
  Tool homepage: https://github.com/lapce/lapce"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lap:1.1.r186--py27_0
stdout: lap.out
