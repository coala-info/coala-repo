cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-safe
label: perl-safe
doc: "A tool for the safe execution of Perl code in restricted compartments.\n\nTool
  homepage: https://github.com/google/re2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-safe:2.37--pl5.22.0_0
stdout: perl-safe.out
