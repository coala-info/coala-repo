cwlVersion: v1.2
class: CommandLineTool
baseCommand: repeatafterme_extend-stk.pl
label: repeatafterme_extend-stk.pl
doc: "The provided text is a container execution error log and does not contain the
  help documentation or usage instructions for the tool.\n\nTool homepage: https://github.com/Dfam-consortium/RepeatAfterMe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatafterme:0.0.7--h7b50bb2_0
stdout: repeatafterme_extend-stk.pl.out
