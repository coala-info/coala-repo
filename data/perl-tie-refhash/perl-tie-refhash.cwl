cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-tie-refhash
label: perl-tie-refhash
doc: "A Perl module that provides the ability to use references as hash keys. (Note:
  The provided help text contains only execution error logs and no usage information.)\n
  \nTool homepage: http://metacpan.org/pod/Tie::RefHash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-tie-refhash:1.39--pl526_1
stdout: perl-tie-refhash.out
