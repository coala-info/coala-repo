cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-data-match
label: perl-data-match
doc: "A tool for data matching (Note: The provided help text contains only execution
  logs and an error indicating the executable was not found; no specific usage or
  arguments were listed).\n\nTool homepage: http://metacpan.org/pod/Data::Match"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-data-match:0.06--pl526_0
stdout: perl-data-match.out
