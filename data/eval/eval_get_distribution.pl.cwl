cwlVersion: v1.2
class: CommandLineTool
baseCommand: eval_get_distribution.pl
label: eval_get_distribution.pl
doc: "The provided text does not contain help information for the tool; it contains
  system log messages and a fatal error regarding container execution and disk space.\n
  \nTool homepage: http://mblab.wustl.edu/software.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eval:2.2.8--pl526_0
stdout: eval_get_distribution.pl.out
