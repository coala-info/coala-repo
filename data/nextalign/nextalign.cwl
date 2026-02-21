cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextalign
label: nextalign
doc: "Nextalign is a tool for sequence alignment and translation, often used for viral
  genomes.\n\nTool homepage: https://github.com/nextstrain/nextclade/tree/master/packages/nextalign_cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextalign:2.14.0--h9ee0642_2
stdout: nextalign.out
