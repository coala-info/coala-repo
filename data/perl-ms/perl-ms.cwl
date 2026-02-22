cwlVersion: v1.2
class: CommandLineTool
baseCommand: ms
label: perl-ms
doc: "Hudson's ms program for generating samples under a neutral model. (Note: The
  provided help text contains system error messages and does not list specific command-line
  arguments.)\n\nTool homepage: http://metacpan.org/pod/MS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-ms:0.207003--pl5321hdfd78af_0
stdout: perl-ms.out
