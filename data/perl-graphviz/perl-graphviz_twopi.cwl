cwlVersion: v1.2
class: CommandLineTool
baseCommand: twopi
label: perl-graphviz_twopi
doc: "Radial layout of graphs. (Note: The provided text is a system error log indicating
  a failure to build the container image due to insufficient disk space and does not
  contain the tool's help documentation.)\n\nTool homepage: https://metacpan.org/pod/GraphViz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-graphviz:2.26--pl5321h46c88eb_0
stdout: perl-graphviz_twopi.out
