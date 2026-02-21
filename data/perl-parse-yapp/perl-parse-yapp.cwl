cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-parse-yapp
label: perl-parse-yapp
doc: "The tool 'perl-parse-yapp' was not found or could not be executed in the provided
  environment. No help text was available to parse arguments.\n\nTool homepage: http://metacpan.org/pod/Parse::Yapp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-parse-yapp:1.21--pl526_0
stdout: perl-parse-yapp.out
