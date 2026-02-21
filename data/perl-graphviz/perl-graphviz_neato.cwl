cwlVersion: v1.2
class: CommandLineTool
baseCommand: neato
label: perl-graphviz_neato
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is a log of a failed container build process due to insufficient disk
  space ('no space left on device').\n\nTool homepage: https://metacpan.org/pod/GraphViz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-graphviz:2.26--pl5321h46c88eb_0
stdout: perl-graphviz_neato.out
