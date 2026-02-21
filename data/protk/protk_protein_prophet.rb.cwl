cwlVersion: v1.2
class: CommandLineTool
baseCommand: protk_protein_prophet.rb
label: protk_protein_prophet.rb
doc: "ProteinProphet analysis tool from the Protk proteomics toolkit. (Note: The provided
  help text contains container runtime errors and does not list specific arguments.)\n
  \nTool homepage: https://github.com/iracooke/protk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
stdout: protk_protein_prophet.rb.out
