cwlVersion: v1.2
class: CommandLineTool
baseCommand: protk_msgfplus_search.rb
label: protk_msgfplus_search.rb
doc: "MS-GF+ search tool (Note: The provided text appears to be a container build
  error log rather than help text; no arguments could be extracted from the input).\n
  \nTool homepage: https://github.com/iracooke/protk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
stdout: protk_msgfplus_search.rb.out
