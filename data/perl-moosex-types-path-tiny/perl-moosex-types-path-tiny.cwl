cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-moosex-types-path-tiny
label: perl-moosex-types-path-tiny
doc: "The tool 'perl-moosex-types-path-tiny' was not found in the system path, and
  no help text was provided to parse.\n\nTool homepage: https://github.com/moose/MooseX-Types-Path-Tiny"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-moosex-types-path-tiny:0.012--pl526_1
stdout: perl-moosex-types-path-tiny.out
