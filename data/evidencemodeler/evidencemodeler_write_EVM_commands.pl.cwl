cwlVersion: v1.2
class: CommandLineTool
baseCommand: evidencemodeler_write_EVM_commands.pl
label: evidencemodeler_write_EVM_commands.pl
doc: "A script to generate EvidenceModeler (EVM) command lines. Note: The provided
  help text contains only system error messages and no usage information.\n\nTool
  homepage: https://github.com/EVidenceModeler/EVidenceModeler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evidencemodeler:2.1.0--h9948957_5
stdout: evidencemodeler_write_EVM_commands.pl.out
