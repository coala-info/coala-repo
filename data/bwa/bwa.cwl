cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwa
label: bwa
doc: "Burrows-Wheeler Aligner\n\nTool homepage: https://github.com/lh3/bwa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
stdout: bwa.out
