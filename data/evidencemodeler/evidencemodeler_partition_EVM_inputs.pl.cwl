cwlVersion: v1.2
class: CommandLineTool
baseCommand: evidencemodeler_partition_EVM_inputs.pl
label: evidencemodeler_partition_EVM_inputs.pl
doc: "A tool to partition EvidenceModeler (EVM) inputs into smaller chunks for parallel
  processing. Note: The provided help text contains only system error messages regarding
  container execution and does not list specific command-line arguments.\n\nTool homepage:
  https://github.com/EVidenceModeler/EVidenceModeler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evidencemodeler:2.1.0--h9948957_5
stdout: evidencemodeler_partition_EVM_inputs.pl.out
