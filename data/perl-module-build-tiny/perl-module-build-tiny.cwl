cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-module-build-tiny
label: perl-module-build-tiny
doc: "A tiny replacement for Module::Build for Perl modules.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-module-build-tiny:0.039--0
stdout: perl-module-build-tiny.out
