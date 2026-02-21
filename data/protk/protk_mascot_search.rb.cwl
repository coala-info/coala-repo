cwlVersion: v1.2
class: CommandLineTool
baseCommand: protk_mascot_search.rb
label: protk_mascot_search.rb
doc: "Mascot search tool (Note: The provided text is a container build error log and
  does not contain the tool's help documentation or argument definitions).\n\nTool
  homepage: https://github.com/iracooke/protk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
stdout: protk_mascot_search.rb.out
