cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-capture-tiny
label: perl-capture-tiny
doc: "The provided text does not contain help information for perl-capture-tiny; it
  is an error log indicating the executable was not found.\n\nTool homepage: https://github.com/dagolden/Capture-Tiny"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-capture-tiny:0.48--pl526_0
stdout: perl-capture-tiny.out
