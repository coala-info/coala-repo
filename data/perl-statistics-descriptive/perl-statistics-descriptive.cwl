cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-statistics-descriptive
label: perl-statistics-descriptive
doc: "A Perl module that provides basic descriptive statistical functions. (Note:
  The provided text contains system error messages regarding container image retrieval
  and does not contain CLI help documentation; therefore, no arguments could be extracted.)\n\
  \nTool homepage: http://web-cpan.shlomifish.org/modules/Statistics-Descriptive/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-statistics-descriptive:3.0801--pl5321hdfd78af_0
stdout: perl-statistics-descriptive.out
