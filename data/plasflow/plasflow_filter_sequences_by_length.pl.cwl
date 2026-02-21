cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasflow_filter_sequences_by_length.pl
label: plasflow_filter_sequences_by_length.pl
doc: "A script to filter sequences by length. Note: The provided help text contains
  system error logs and does not list specific arguments.\n\nTool homepage: https://github.com/smaegol/PlasFlow"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasflow:1.1.0--py35_0
stdout: plasflow_filter_sequences_by_length.pl.out
