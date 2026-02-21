cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-details
label: perl-file-details
doc: "A tool for retrieving file details (Note: The provided input contains execution
  logs and an error message rather than help text; therefore, specific arguments could
  not be extracted).\n\nTool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-details:0.003--0
stdout: perl-file-details.out
