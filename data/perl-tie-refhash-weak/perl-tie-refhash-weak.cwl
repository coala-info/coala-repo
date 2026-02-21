cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-tie-refhash-weak
label: perl-tie-refhash-weak
doc: "A Perl module (Tie::RefHash::Weak) that provides a hash with weakened references.
  (Note: The provided text is an error log indicating the executable was not found,
  so no arguments could be parsed from the help text.)\n\nTool homepage: http://metacpan.org/pod/Tie::RefHash::Weak"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-tie-refhash-weak:0.09--pl526_2
stdout: perl-tie-refhash-weak.out
