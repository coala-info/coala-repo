cwlVersion: v1.2
class: CommandLineTool
baseCommand: protk_protxml_to_gff.rb
label: protk_protxml_to_gff.rb
doc: "Convert ProtXML files to GFF format (Note: The provided help text contains only
  container runtime logs and a fatal error, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/iracooke/protk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
stdout: protk_protxml_to_gff.rb.out
