cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sort-naturally
label: perl-sort-naturally
doc: "A utility to sort strings naturally (lexically, but with numeric parts sorted
  numerically). Note: The provided help text indicates a fatal error where the executable
  was not found, so no specific arguments could be extracted.\n\nTool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sort-naturally:1.03--0
stdout: perl-sort-naturally.out
