cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-text-ansitable
label: perl-text-ansitable
doc: "A tool for generating text tables with ANSI color support. (Note: The provided
  input text contains execution logs and an error indicating the executable was not
  found, rather than standard help documentation.)\n\nTool homepage: https://github.com/perlancar/perl-Text-ANSITable"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-text-ansitable:0.48--pl5.22.0_0
stdout: perl-text-ansitable.out
