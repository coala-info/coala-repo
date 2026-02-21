cwlVersion: v1.2
class: CommandLineTool
baseCommand: eval_evaluate_gtf.pl
label: eval_evaluate_gtf.pl
doc: "Evaluate GTF files (Note: The provided text contains system error messages regarding
  container execution and does not include the tool's help documentation or usage
  instructions).\n\nTool homepage: http://mblab.wustl.edu/software.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eval:2.2.8--pl526_0
stdout: eval_evaluate_gtf.pl.out
