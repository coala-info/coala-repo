cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-math-random
label: perl-math-random
doc: "A Perl module providing a comprehensive set of random number generators. (Note:
  The provided text contains system error logs rather than command-line help documentation.)\n\
  \nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-math-random:0.72--pl5321h7b50bb2_8
stdout: perl-math-random.out
