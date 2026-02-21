cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-graphviz
label: perl-graphviz
doc: "The provided text is a system error log indicating a failure to build or extract
  the container image for perl-graphviz due to insufficient disk space. It does not
  contain the tool's help text or usage information.\n\nTool homepage: https://metacpan.org/pod/GraphViz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-graphviz:2.26--pl5321h46c88eb_0
stdout: perl-graphviz.out
