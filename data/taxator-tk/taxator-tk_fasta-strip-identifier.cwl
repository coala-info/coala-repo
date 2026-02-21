cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxator-tk
  - fasta-strip-identifier
label: taxator-tk_fasta-strip-identifier
doc: "The provided text does not contain help information for the tool, but instead
  shows a container build error (FATAL: Unable to handle docker://... uri). Based
  on the tool name, this utility likely strips identifiers from FASTA files.\n\nTool
  homepage: https://github.com/fungs/taxator-tk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxator-tk:1.3.3e--0
stdout: taxator-tk_fasta-strip-identifier.out
