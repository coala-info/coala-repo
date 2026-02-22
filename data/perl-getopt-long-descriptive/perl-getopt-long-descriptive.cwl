cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-getopt-long-descriptive
label: perl-getopt-long-descriptive
doc: "The provided text is a system error log regarding a container build failure
  (no space left on device) and does not contain help text or argument definitions
  for the tool.\n\nTool homepage: https://github.com/rjbs/Getopt-Long-Descriptive"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-getopt-long-descriptive:0.116--pl5321hdfd78af_0
stdout: perl-getopt-long-descriptive.out
