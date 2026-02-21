cwlVersion: v1.2
class: CommandLineTool
baseCommand: esl-alicompare2rf
label: perl-bio-easel_esl-alicompare2rf
doc: "The provided text is a system error log regarding a container build failure
  and does not contain help documentation or usage instructions for the tool.\n\n
  Tool homepage: https://github.com/nawrockie/Bio-Easel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-easel:0.17--pl5321h7b50bb2_0
stdout: perl-bio-easel_esl-alicompare2rf.out
