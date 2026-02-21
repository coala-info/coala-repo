cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-appconfig
label: perl-appconfig
doc: "The provided text does not contain help information or usage instructions for
  the tool; it consists of system logs indicating that the executable was not found.\n
  \nTool homepage: https://github.com/ajay04323/cpanel_CPSP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-appconfig:1.71--pl526_1
stdout: perl-appconfig.out
