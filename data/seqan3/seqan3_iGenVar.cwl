cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqan3_iGenVar
label: seqan3_iGenVar
doc: "The provided text does not contain help information for seqan3_iGenVar; it contains
  error logs related to a failed container build (no space left on device).\n\nTool
  homepage: https://www.seqan.de"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqan3:3.4.0--haf24da9_0
stdout: seqan3_iGenVar.out
