cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqan_tcoffee
label: seqan_tcoffee
doc: "A multiple sequence alignment tool. (Note: The provided text contains system
  error messages regarding a container build failure and does not include the tool's
  help documentation or argument list.)\n\nTool homepage: http://www.seqan.de/apps/seqan-t-coffee/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqan:2.4.0--0
stdout: seqan_tcoffee.out
