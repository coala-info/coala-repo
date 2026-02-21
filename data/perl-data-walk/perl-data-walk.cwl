cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-data-walk
label: perl-data-walk
doc: "A tool for traversing Perl data structures (Note: The provided help text contains
  only execution errors and no usage information).\n\nTool homepage: https://github.com/danboo/perl-data-leaf-walker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-data-walk:2.01--pl5.22.0_0
stdout: perl-data-walk.out
