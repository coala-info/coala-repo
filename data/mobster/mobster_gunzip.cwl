cwlVersion: v1.2
class: CommandLineTool
baseCommand: mobster_gunzip
label: mobster_gunzip
doc: "A tool associated with the Mobster suite, likely used for decompressing files.
  Note: The provided help text contains only container runtime error messages and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/jyhehir/mobster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mobster:0.2.4.1--1
stdout: mobster_gunzip.out
