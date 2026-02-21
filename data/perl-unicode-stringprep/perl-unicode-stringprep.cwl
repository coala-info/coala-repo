cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-unicode-stringprep
label: perl-unicode-stringprep
doc: "The provided text does not contain help documentation for 'perl-unicode-stringprep'.
  It contains system logs indicating that the executable was not found in the PATH.\n
  \nTool homepage: https://github.com/cfaerber/Unicode-Stringprep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-unicode-stringprep:1.105--1
stdout: perl-unicode-stringprep.out
