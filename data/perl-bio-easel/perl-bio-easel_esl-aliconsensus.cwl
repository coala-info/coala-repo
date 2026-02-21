cwlVersion: v1.2
class: CommandLineTool
baseCommand: esl-aliconsensus
label: perl-bio-easel_esl-aliconsensus
doc: "The provided text is an error log indicating a failure to build or run the container
  (no space left on device). No help text was available to parse for arguments.\n\n
  Tool homepage: https://github.com/nawrockie/Bio-Easel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-easel:0.17--pl5321h7b50bb2_0
stdout: perl-bio-easel_esl-aliconsensus.out
