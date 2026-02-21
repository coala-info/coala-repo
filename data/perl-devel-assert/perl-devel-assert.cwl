cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-devel-assert
label: perl-devel-assert
doc: "The provided text does not contain help information or usage instructions for
  'perl-devel-assert'. It appears to be a log of a failed container execution attempt
  where the executable was not found.\n\nTool homepage: http://metacpan.org/pod/Devel::Assert"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-devel-assert:1.06--pl526h470a237_0
stdout: perl-devel-assert.out
