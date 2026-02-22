cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-class-method-modifiers
label: perl-class-method-modifiers
doc: "A Perl module that provides Moose-like method modifiers (before, after, around).
  Note: The provided text contains system error logs regarding container image creation
  and does not contain CLI usage information.\n\nTool homepage: https://github.com/moose/Class-Method-Modifiers"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-class-method-modifiers:2.13--pl5321hdfd78af_0
stdout: perl-class-method-modifiers.out
