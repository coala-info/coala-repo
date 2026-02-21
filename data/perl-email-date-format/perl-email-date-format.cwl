cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-email-date-format
label: perl-email-date-format
doc: "The provided text does not contain help documentation. It is an error log indicating
  that the executable 'perl-email-date-format' was not found in the system PATH.\n
  \nTool homepage: https://github.com/Taoviqinvicible/Tools-termux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-email-date-format:1.005--pl526_1
stdout: perl-email-date-format.out
