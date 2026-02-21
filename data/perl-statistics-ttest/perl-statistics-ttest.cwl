cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-statistics-ttest
label: perl-statistics-ttest
doc: "The provided text is an error log indicating that the executable 'perl-statistics-ttest'
  was not found in the environment. No help text or usage information was available
  to parse arguments.\n\nTool homepage: https://github.com/pld-linux/perl-Statistics-TTest"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-statistics-ttest:1.1--0
stdout: perl-statistics-ttest.out
