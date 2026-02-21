cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-heap
label: perl-heap
doc: "The tool 'perl-heap' could not be executed as it was not found in the system
  path. No help text was available to parse.\n\nTool homepage: http://metacpan.org/pod/Heap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-heap:0.80--pl526_0
stdout: perl-heap.out
