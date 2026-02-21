cwlVersion: v1.2
class: CommandLineTool
baseCommand: eval_filter_gtf.pl
label: eval_filter_gtf.pl
doc: "A script for filtering GTF files. (Note: The provided help text contains system
  error messages regarding container execution and does not list specific command-line
  arguments.)\n\nTool homepage: http://mblab.wustl.edu/software.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eval:2.2.8--pl526_0
stdout: eval_filter_gtf.pl.out
