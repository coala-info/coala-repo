cwlVersion: v1.2
class: CommandLineTool
baseCommand: masurca_close_scaffold_gaps.sh
label: masurca_close_scaffold_gaps.sh
doc: "A tool for closing gaps in scaffolds. (Note: The provided help text contains
  system error messages regarding container execution and does not list command-line
  arguments.)\n\nTool homepage: http://masurca.blogspot.co.uk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/masurca:4.1.4--h6b3f7d6_0
stdout: masurca_close_scaffold_gaps.sh.out
