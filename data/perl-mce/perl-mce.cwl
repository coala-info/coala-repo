cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-mce
label: perl-mce
doc: "The Many-Core Engine (MCE) for Perl provides parallel processing capabilities.
  (Note: The provided text contains container runtime error messages rather than tool
  help text, so no arguments could be extracted.)\n\nTool homepage: https://github.com/marioroy/mce-perl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-mce:1.902--pl5321hdfd78af_0
stdout: perl-mce.out
