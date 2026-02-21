cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-devel-cycle
label: perl-devel-cycle
doc: "A tool to find memory cycles in Perl objects (Note: The provided help text contains
  only system error logs and no usage information).\n\nTool homepage: http://metacpan.org/pod/Devel::Cycle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-devel-cycle:1.12--pl526_0
stdout: perl-devel-cycle.out
