cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-term-progressbar
label: perl-term-progressbar
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error messages related to disk space issues during
  a container image pull.\n\nTool homepage: https://github.com/manwar/Term-ProgressBar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-term-progressbar:2.23--pl5321hdfd78af_0
stdout: perl-term-progressbar.out
