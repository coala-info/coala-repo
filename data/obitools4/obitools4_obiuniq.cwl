cwlVersion: v1.2
class: CommandLineTool
baseCommand: obiuniq
label: obitools4_obiuniq
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image conversion and disk
  space.\n\nTool homepage: https://obitools4.metabarcoding.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
stdout: obitools4_obiuniq.out
