cwlVersion: v1.2
class: CommandLineTool
baseCommand: use-devel-checklib
label: perl-devel-checklib_use-devel-checklib
doc: "The provided text is an error log from a container build process and does not
  contain help information or argument definitions for the tool.\n\nTool homepage:
  http://metacpan.org/pod/Devel-CheckLib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-devel-checklib:1.16--pl5321h7b50bb2_1
stdout: perl-devel-checklib_use-devel-checklib.out
