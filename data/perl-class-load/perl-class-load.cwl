cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-class-load
label: perl-class-load
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed execution attempt where the executable was not found in the PATH.\n\n
  Tool homepage: https://github.com/moose/Class-Load"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-class-load:0.25--pl526_0
stdout: perl-class-load.out
