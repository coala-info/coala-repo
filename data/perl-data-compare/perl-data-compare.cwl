cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-data-compare
label: perl-data-compare
doc: "Data::Compare - compare perl data structures\n\nTool homepage: http://metacpan.org/pod/Data::Compare"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-data-compare:1.25--pl526_0
stdout: perl-data-compare.out
