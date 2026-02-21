cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl
label: perl-statistics-r_pdl
doc: "A Perl module that controls the R interpreter. (Note: The provided text is a
  build error log and does not contain CLI help information.)\n\nTool homepage: https://github.com/PDLPorters/PDL-Stats"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-statistics-r:0.34--pl5321r44hdfd78af_7
stdout: perl-statistics-r_pdl.out
