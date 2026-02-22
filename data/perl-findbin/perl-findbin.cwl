cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-findbin
label: perl-findbin
doc: "The provided text does not contain help information or usage instructions. It
  consists of system error messages related to a lack of disk space during a container
  image conversion process.\n\nTool homepage: https://metacpan.org/pod/FindBin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-findbin:1.54--pl5321hdfd78af_0
stdout: perl-findbin.out
