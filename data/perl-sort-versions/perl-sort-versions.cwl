cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sort-versions
label: perl-sort-versions
doc: "A tool to sort version numbers (Note: The provided text contains only execution
  logs and no help documentation; no arguments could be extracted).\n\nTool homepage:
  https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sort-versions:1.62--0
stdout: perl-sort-versions.out
