cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-git-wrapper
label: perl-git-wrapper
doc: "A tool for wrapping Git commands in Perl (Note: The provided help text contains
  system error logs indicating the executable was not found, so no specific arguments
  could be parsed).\n\nTool homepage: http://genehack.github.com/Git-Wrapper/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-git-wrapper:0.048--pl526_0
stdout: perl-git-wrapper.out
