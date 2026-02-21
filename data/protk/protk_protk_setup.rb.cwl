cwlVersion: v1.2
class: CommandLineTool
baseCommand: protk_protk_setup.rb
label: protk_protk_setup.rb
doc: "A tool for setting up the Protk proteomics toolkit environment.\n\nTool homepage:
  https://github.com/iracooke/protk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
stdout: protk_protk_setup.rb.out
