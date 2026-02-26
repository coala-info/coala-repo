cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextalign
label: nextalign_Generate
doc: "Nextalign is a tool for aligning sequences to a reference genome.\n\nTool homepage:
  https://github.com/nextstrain/nextclade/tree/master/packages/nextalign_cli"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to run (e.g., generate, align, view)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextalign:2.14.0--h9ee0642_1
stdout: nextalign_Generate.out
