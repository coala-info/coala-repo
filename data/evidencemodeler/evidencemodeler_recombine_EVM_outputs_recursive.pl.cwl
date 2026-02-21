cwlVersion: v1.2
class: CommandLineTool
baseCommand: evidencemodeler_recombine_EVM_outputs_recursive.pl
label: evidencemodeler_recombine_EVM_outputs_recursive.pl
doc: "A script to recombine EvidenceModeler (EVM) outputs recursively. Note: The provided
  help text contains a system error and does not list specific command-line arguments.\n
  \nTool homepage: https://github.com/EVidenceModeler/EVidenceModeler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evidencemodeler:2.1.0--h9948957_5
stdout: evidencemodeler_recombine_EVM_outputs_recursive.pl.out
