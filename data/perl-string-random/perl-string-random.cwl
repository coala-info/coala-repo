cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-string-random
label: perl-string-random
doc: "A tool for generating random strings based on patterns (Note: No help text was
  provided in the input to extract specific arguments).\n\nTool homepage: http://metacpan.org/release/String-Random"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-string-random:0.30--pl522_0
stdout: perl-string-random.out
