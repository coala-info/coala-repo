cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-git-wrapper-plus
label: perl-git-wrapper-plus
doc: "A tool related to Git Wrapper Plus in Perl (Note: The provided text contains
  execution logs and an error message rather than help documentation; no arguments
  could be extracted).\n\nTool homepage: https://github.com/kentnl/Git-Wrapper-Plus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-git-wrapper-plus:0.004011--pl526_0
stdout: perl-git-wrapper-plus.out
