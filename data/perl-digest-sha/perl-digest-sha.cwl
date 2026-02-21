cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-digest-sha
label: perl-digest-sha
doc: "The provided text does not contain help information as the executable was not
  found in the environment. No arguments could be parsed.\n\nTool homepage: https://github.com/pld-linux/perl-Digest-SHA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-digest-sha:5.88--pl5.22.0_0
stdout: perl-digest-sha.out
