cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl
label: perl-mojo-pg
doc: "Mojo::Pg is a tiny wrapper around DBD::Pg that makes PostgreSQL a lot of fun
  to use with the Mojolicious real-time web framework.\n\nTool homepage: https://mojolicious.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-mojo-pg:4.28--pl5321hdfd78af_0
stdout: perl-mojo-pg.out
