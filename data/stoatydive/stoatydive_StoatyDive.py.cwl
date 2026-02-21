cwlVersion: v1.2
class: CommandLineTool
baseCommand: StoatyDive.py
label: stoatydive_StoatyDive.py
doc: "StoatyDive is a tool for evaluating the quality of peak calling. (Note: The
  provided text contains container runtime error logs rather than the tool's help
  documentation; no arguments could be extracted from the input.)\n\nTool homepage:
  https://github.com/heylf/StoatyDive"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stoatydive:1.1.1--pyh5e36f6f_0
stdout: stoatydive_StoatyDive.py.out
