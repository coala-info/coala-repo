cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-class-trigger
label: perl-class-trigger
doc: "A Perl mixin to add triggers to your class (Class::Trigger). Note: The provided
  text contains system error logs regarding container extraction and does not list
  specific command-line arguments.\n\nTool homepage: https://github.com/miyagawa/Class-Trigger"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-class-trigger:0.15--pl5321hdfd78af_1
stdout: perl-class-trigger.out
