cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-automatedannotation
label: perl-bio-automatedannotation
doc: "A tool for automated biological sequence annotation. Note: The provided help
  text contains system error messages regarding disk space and container image handling
  rather than command usage instructions.\n\nTool homepage: http://www.sanger.ac.uk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-bio-automatedannotation:2023.03.14.16.40.01.685--pl5321hdfd78af_0
stdout: perl-bio-automatedannotation.out
