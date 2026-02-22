cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-memoize
label: perl-memoize
doc: "A Perl module that makes functions faster by trading space for time. (Note:
  The provided text contains system error messages regarding container execution and
  disk space rather than CLI help text; therefore, no arguments could be extracted.)\n\
  \nTool homepage: http://metacpan.org/pod/Memoize"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-memoize:1.09--pl5321hdfd78af_0
stdout: perl-memoize.out
