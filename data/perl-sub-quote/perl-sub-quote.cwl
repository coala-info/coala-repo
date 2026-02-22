cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sub-quote
label: perl-sub-quote
doc: "Sub::Quote - efficient generation of subroutines via string eval. (Note: The
  provided text contains system error messages regarding container image retrieval
  and does not contain CLI help documentation.)\n\nTool homepage: http://metacpan.org/pod/Sub::Quote"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sub-quote:2.006006--pl5321hdfd78af_0
stdout: perl-sub-quote.out
