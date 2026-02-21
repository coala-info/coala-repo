cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-data-predicate
label: perl-data-predicate
doc: "Data::Predicate - check if a data structure satisfies a predicate\n\nTool homepage:
  http://metacpan.org/pod/Data::Predicate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-data-predicate:2.1.1--pl526_0
stdout: perl-data-predicate.out
