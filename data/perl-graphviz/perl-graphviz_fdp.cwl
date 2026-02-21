cwlVersion: v1.2
class: CommandLineTool
baseCommand: fdp
label: perl-graphviz_fdp
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating a failure to build or run a container due to insufficient disk space.\n
  \nTool homepage: https://metacpan.org/pod/GraphViz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-graphviz:2.26--pl5321h46c88eb_0
stdout: perl-graphviz_fdp.out
