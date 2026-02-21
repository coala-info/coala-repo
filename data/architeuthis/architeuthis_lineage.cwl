cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - architeuthis
  - lineage
label: architeuthis_lineage
doc: "A subcommand of the architeuthis tool (Note: The provided input was a runtime
  error/stack trace rather than help text, so specific arguments could not be extracted).\n
  \nTool homepage: https://github.com/cdiener/architeuthis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/architeuthis:0.5.0--he881be0_0
stdout: architeuthis_lineage.out
