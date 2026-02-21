cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-heap-simple
label: perl-heap-simple
doc: "A Perl-based tool for heap management. (Note: The provided help text indicates
  an execution error and does not contain usage information.)\n\nTool homepage: https://github.com/gitpan/Heap-Simple-Perl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-heap-simple:0.13--pl526_1
stdout: perl-heap-simple.out
