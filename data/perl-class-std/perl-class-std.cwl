cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-class-std
label: perl-class-std
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating that the executable 'perl-class-std' was not found in the system
  PATH.\n\nTool homepage: https://github.com/pld-linux/perl-Class-Std"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-class-std:0.013--0
stdout: perl-class-std.out
