cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-lyve-set
label: perl-lyve-set
doc: "The provided text does not contain help information as the executable was not
  found in the environment.\n\nTool homepage: https://github.com/lskatz/lyve-SET"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-lyve-set:2.0.1--pl526_0
stdout: perl-lyve-set.out
