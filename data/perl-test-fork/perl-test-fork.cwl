cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-fork
label: perl-test-fork
doc: "The provided text does not contain help information for 'perl-test-fork'. It
  appears to be a log of a failed execution attempt where the executable was not found
  in the environment.\n\nTool homepage: http://metacpan.org/pod/Test::Fork"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-fork:0.02--pl526_0
stdout: perl-test-fork.out
