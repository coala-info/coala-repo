cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test2-plugin-nowarnings
label: perl-test2-plugin-nowarnings
doc: "A Perl Test2 plugin that causes tests to fail if any warnings are issued during
  execution.\n\nTool homepage: https://metacpan.org/release/Test2-Plugin-NoWarnings"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-test2-plugin-nowarnings:0.10--pl5321hdfd78af_0
stdout: perl-test2-plugin-nowarnings.out
