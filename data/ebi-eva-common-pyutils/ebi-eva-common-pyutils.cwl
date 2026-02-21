cwlVersion: v1.2
class: CommandLineTool
baseCommand: ebi-eva-common-pyutils
label: ebi-eva-common-pyutils
doc: "Common Python utilities for the European Variation Archive (EVA). Note: The
  provided text contains system error logs regarding a container runtime failure (no
  space left on device) and does not contain actual command-line help information
  or usage instructions.\n\nTool homepage: https://github.com/EBIVariation/eva-common-pyutils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ebi-eva-common-pyutils:0.8.0--pyh7e72e81_0
stdout: ebi-eva-common-pyutils.out
