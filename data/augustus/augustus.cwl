cwlVersion: v1.2
class: CommandLineTool
baseCommand: augustus
label: augustus
doc: "Augustus is a gene prediction tool for eukaryotic genomic sequences. (Note:
  The provided text contains system error messages regarding container execution and
  does not include the standard help documentation or argument list.)\n\nTool homepage:
  http://bioinf.uni-greifswald.de/augustus/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augustus:3.5.0--pl5321h9716f88_9
stdout: augustus.out
