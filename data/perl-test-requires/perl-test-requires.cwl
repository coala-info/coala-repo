cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-requires
label: perl-test-requires
doc: "A Perl module (Test::Requires) used to check for the availability of modules
  during testing. Note: The provided text contains system error messages regarding
  disk space and container image conversion rather than command-line help documentation.\n\
  \nTool homepage: https://github.com/tokuhirom/Test-Requires"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-requires:0.11--pl5321hdfd78af_1
stdout: perl-test-requires.out
