cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-slurp-tiny
label: perl-file-slurp-tiny
doc: "A simple, sane and efficient file slurper (Note: The provided text is an error
  log indicating the executable was not found, so no arguments could be parsed).\n
  \nTool homepage: https://github.com/pld-linux/perl-File-Slurp-Tiny"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-slurp-tiny:0.004--0
stdout: perl-file-slurp-tiny.out
