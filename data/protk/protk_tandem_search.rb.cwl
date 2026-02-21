cwlVersion: v1.2
class: CommandLineTool
baseCommand: protk_tandem_search.rb
label: protk_tandem_search.rb
doc: "A tool from the Protk suite for running X!Tandem protein identification searches.
  (Note: The provided help text contained system logs and error messages rather than
  usage information, so no arguments could be extracted.)\n\nTool homepage: https://github.com/iracooke/protk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
stdout: protk_tandem_search.rb.out
