cwlVersion: v1.2
class: CommandLineTool
baseCommand: protk_peptide_prophet.rb
label: protk_peptide_prophet.rb
doc: "PeptideProphet analysis tool from the protk toolkit. (Note: The provided input
  text contains container runtime errors and does not include the actual help documentation
  for the tool's arguments.)\n\nTool homepage: https://github.com/iracooke/protk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
stdout: protk_peptide_prophet.rb.out
