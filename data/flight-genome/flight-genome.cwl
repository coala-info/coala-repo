cwlVersion: v1.2
class: CommandLineTool
baseCommand: flight-genome
label: flight-genome
doc: "The provided text does not contain help information or usage instructions; it
  consists of system log messages and a fatal error regarding disk space during a
  container build.\n\nTool homepage: https://github.com/rhysnewell/flight"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flight-genome:1.6.3--pyh7cba7a3_0
stdout: flight-genome.out
