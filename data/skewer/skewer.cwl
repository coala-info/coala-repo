cwlVersion: v1.2
class: CommandLineTool
baseCommand: skewer
label: skewer
doc: "A tool for processing next-generation sequencing (NGS) paired-end reads (Note:
  The provided text contains error logs rather than help documentation, so arguments
  could not be extracted).\n\nTool homepage: https://github.com/skeeto/skewer-mode"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skewer:0.2.2--h2d50403_2
stdout: skewer.out
