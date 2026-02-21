cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-extutils-config
label: perl-extutils-config
doc: "A wrapper for Perl's ExtUtils::Config. (Note: The provided text is an error
  log indicating the executable was not found, rather than help text; therefore, no
  arguments could be extracted.)\n\nTool homepage: https://github.com/pld-linux/perl-ExtUtils-PkgConfig"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-extutils-config:0.008--pl526_2
stdout: perl-extutils-config.out
