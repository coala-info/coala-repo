cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-memory-cycle
label: perl-test-memory-cycle
doc: "A tool to check for memory cycles in Perl objects. (Note: The provided help
  text contains only execution errors and no usage information.)\n\nTool homepage:
  http://metacpan.org/pod/Test::Memory::Cycle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-memory-cycle:1.06--pl526_0
stdout: perl-test-memory-cycle.out
