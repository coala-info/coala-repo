cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-minion
label: perl-minion
doc: "A job queue for the Mojolicious real-time web framework.\n\nTool homepage: https://mojolicious.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-minion:11.0--pl5321hdfd78af_0
stdout: perl-minion.out
