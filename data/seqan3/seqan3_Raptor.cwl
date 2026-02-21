cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqan3_Raptor
label: seqan3_Raptor
doc: "The provided text is a container execution error log and does not contain help
  information or argument definitions for the tool.\n\nTool homepage: https://www.seqan.de"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqan3:3.4.0--haf24da9_0
stdout: seqan3_Raptor.out
