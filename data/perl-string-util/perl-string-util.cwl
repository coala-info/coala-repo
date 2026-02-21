cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-string-util
label: perl-string-util
doc: "The provided text does not contain help information as the executable was not
  found in the environment. No arguments could be parsed.\n\nTool homepage: http://metacpan.org/pod/String::Util"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-string-util:1.26--pl5.22.0_0
stdout: perl-string-util.out
