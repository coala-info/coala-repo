cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-http-tiny
label: perl-http-tiny
doc: "A small, simple, correct HTTP/1.1 client\n\nTool homepage: https://github.com/chansen/p5-http-tiny"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-http-tiny:0.076--pl526_0
stdout: perl-http-tiny.out
