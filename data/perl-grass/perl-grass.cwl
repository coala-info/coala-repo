cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-grass
label: perl-grass
doc: "The provided text is a system error log regarding a failed container build/pull
  process and does not contain help documentation or argument definitions for the
  tool.\n\nTool homepage: https://github.com/damienogrady/GrassPerlenSpiel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-grass:1.1.6--2
stdout: perl-grass.out
