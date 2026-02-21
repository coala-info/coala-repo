cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-statistics-basic
label: perl-statistics-basic
doc: "The provided text indicates a fatal error where the executable 'perl-statistics-basic'
  was not found in the system PATH. As a result, no help text or argument information
  is available to parse.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-statistics-basic:1.6611--1
stdout: perl-statistics-basic.out
