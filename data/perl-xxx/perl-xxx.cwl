cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xxx
label: perl-xxx
doc: "A tool from the perl-xxx package (Note: The provided text contains error logs
  rather than help documentation, so no arguments could be extracted).\n\nTool homepage:
  https://github.com/ingydotnet/xxx-pm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xxx:0.38--pl5321hdfd78af_0
stdout: perl-xxx.out
