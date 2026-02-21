cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-symbol-util
label: perl-symbol-util
doc: "Perl module for manipulating symbols and symbol tables (Note: The provided text
  is an error log and does not contain CLI help information).\n\nTool homepage: https://github.com/dex4er/perl-Symbol-Util"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-symbol-util:0.0203--pl526_1
stdout: perl-symbol-util.out
