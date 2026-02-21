cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-easel
label: perl-bio-easel
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build or extract the container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/nawrockie/Bio-Easel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-easel:0.17--pl5321h7b50bb2_0
stdout: perl-bio-easel.out
