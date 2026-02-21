cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-statistics-lite
label: perl-statistics-lite
doc: "A tool for lightweight statistical calculations. (Note: The provided help text
  indicates a system error where the executable was not found, so no specific arguments
  could be extracted from the output.)\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-statistics-lite:3.62--0
stdout: perl-statistics-lite.out
