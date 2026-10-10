cwlVersion: v1.2
class: CommandLineTool
baseCommand: sgb_to_gtdb_profile.py
label: metaphlan_sgb_to_gtdb_profile
doc: "Convert a MetaPhlAn SGB-based profile into a GTDB-based profile.\n\nTool homepage: https://github.com/biobakery/metaphlan"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: File
    doc: "The input profile"
    inputBinding:
      position: 101
      prefix: "--input"
  - id: output
    type: string
    doc: "The output profile"
    inputBinding:
      position: 101
      prefix: "--output"
outputs:
  - id: gtdb_profile
    type: File
    doc: "The GTDB-based profile"
    outputBinding:
      glob: "$(inputs.output)"
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaphlan:4.2.4--pyhdfd78af_0
stdout: metaphlan_sgb_to_gtdb_profile.out
