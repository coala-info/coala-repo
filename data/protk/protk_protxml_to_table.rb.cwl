cwlVersion: v1.2
class: CommandLineTool
baseCommand: protk_protxml_to_table.rb
label: protk_protxml_to_table.rb
doc: "Convert ProtXML files to table format (Note: The provided text is a system error
  log and does not contain help documentation or argument details).\n\nTool homepage:
  https://github.com/iracooke/protk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
stdout: protk_protxml_to_table.rb.out
