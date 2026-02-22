cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-set-object
label: perl-set-object
doc: "A Perl module that provides a collection of objects (sets), allowing for set
  operations like union and intersection. Note: The provided text contains system
  error messages regarding container image retrieval and does not contain actual CLI
  help documentation.\n\nTool homepage: http://metacpan.org/pod/Set-Object"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-set-object:1.43--pl5321h7b50bb2_0
stdout: perl-set-object.out
