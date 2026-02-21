cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-svg-graph
label: perl-svg-graph
doc: "A Perl-based tool for generating SVG graphs. (Note: The provided help text contains
  a fatal error indicating the executable was not found, so no specific arguments
  could be parsed.)\n\nTool homepage: https://github.com/clbustos/svg-graph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-svg-graph:0.02--pl526_2
stdout: perl-svg-graph.out
