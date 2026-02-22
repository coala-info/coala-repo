cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-osnames
label: perl-perl-osnames
doc: "A tool related to Perl operating system names. (Note: The provided input text
  contains system error messages regarding container extraction and does not contain
  actual help documentation or argument definitions.)\n\nTool homepage: https://metacpan.org/release/Perl-osnames"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-perl-osnames:0.122--pl5321hdfd78af_0
stdout: perl-perl-osnames.out
