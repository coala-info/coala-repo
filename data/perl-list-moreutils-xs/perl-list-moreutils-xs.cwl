cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-list-moreutils-xs
label: perl-list-moreutils-xs
doc: "The provided text is an error log from a container build/execution process and
  does not contain CLI help information or argument definitions.\n\nTool homepage:
  https://metacpan.org/release/List-MoreUtils-XS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-list-moreutils-xs:0.430--pl5321h7b50bb2_5
stdout: perl-list-moreutils-xs.out
