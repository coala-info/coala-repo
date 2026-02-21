cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-statistics-distributions
label: perl-statistics-distributions
doc: "A Perl module/tool for calculating critical values and upper tail probabilities
  of common statistical distributions. Note: The provided help text indicates an execution
  error (executable not found) and does not contain usage information.\n\nTool homepage:
  https://github.com/shlomif/perl-Statistics-Descriptive"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-statistics-distributions:1.02--0
stdout: perl-statistics-distributions.out
