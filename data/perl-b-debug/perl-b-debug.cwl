cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-b-debug
label: perl-b-debug
doc: "The provided text does not contain help information or a description for the
  tool; it contains execution logs indicating a failure to find the executable.\n\n
  Tool homepage: http://metacpan.org/pod/B::Debug"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-b-debug:1.26--pl526_0
stdout: perl-b-debug.out
