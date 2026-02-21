cwlVersion: v1.2
class: CommandLineTool
baseCommand: protk_pepxml_to_table.rb
label: protk_pepxml_to_table.rb
doc: "A tool for converting pepXML files to tabular format (Note: The provided text
  contains only environment logs and a fatal error, no specific argument definitions
  were found in the input).\n\nTool homepage: https://github.com/iracooke/protk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
stdout: protk_pepxml_to_table.rb.out
