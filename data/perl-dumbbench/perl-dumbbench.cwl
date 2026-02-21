cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-dumbbench
label: perl-dumbbench
doc: "A benchmarking tool. (Note: The provided text is an error log indicating the
  executable was not found and does not contain usage instructions or argument definitions.)\n
  \nTool homepage: https://github.com/briandfoy/dumbbench"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-dumbbench:0.111--pl526_0
stdout: perl-dumbbench.out
