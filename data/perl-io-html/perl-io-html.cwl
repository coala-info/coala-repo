cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-html
label: perl-io-html
doc: "The provided text contains system error messages related to a failed container
  build (disk space issues) and does not contain help documentation or usage instructions
  for the tool.\n\nTool homepage: http://metacpan.org/pod/IO-HTML"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-io-html:1.004--pl5321hdfd78af_0
stdout: perl-io-html.out
