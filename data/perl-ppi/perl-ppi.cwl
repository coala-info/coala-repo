cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-ppi
label: perl-ppi
doc: "The provided text does not contain help information as the executable was not
  found in the environment. No arguments or descriptions could be parsed from the
  execution logs.\n\nTool homepage: https://github.com/adamkennedy/PPI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-ppi:1.236--pl526_2
stdout: perl-ppi.out
