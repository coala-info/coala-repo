cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-date-manip
label: perl-date-manip
doc: "A Perl module for date manipulation. Note: The provided text contains system
  error logs regarding container execution and disk space rather than command-line
  help documentation.\n\nTool homepage: https://metacpan.org/pod/Date::Manip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-date-manip:6.98--pl5321hdfd78af_0
stdout: perl-date-manip.out
