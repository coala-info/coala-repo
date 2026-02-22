cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-mce-shared
label: perl-mce-shared
doc: "MCE::Shared provides data sharing capabilities for the Perl Multi-Core Engine.
  (Note: The provided text appears to be a system error log regarding container image
  extraction and does not contain CLI usage instructions or argument definitions).\n\
  \nTool homepage: https://github.com/marioroy/mce-perl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-mce-shared:1.893--pl5321hdfd78af_0
stdout: perl-mce-shared.out
