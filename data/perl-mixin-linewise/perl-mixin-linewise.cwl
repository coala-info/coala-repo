cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-mixin-linewise
label: perl-mixin-linewise
doc: "The provided text contains system error messages regarding disk space and container
  conversion rather than the tool's help documentation. Mixin::Linewise is a Perl
  module used to handle data line-by-line from various sources.\n\nTool homepage:
  https://github.com/rjbs/Mixin-Linewise"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-mixin-linewise:0.111--pl5321hdfd78af_0
stdout: perl-mixin-linewise.out
