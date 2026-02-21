cwlVersion: v1.2
class: CommandLineTool
baseCommand: repeatscout_compare-out-to-gff.prl
label: repeatscout_compare-out-to-gff.prl
doc: "Compare RepeatScout output to GFF. (Note: The provided text contains container
  runtime error messages and does not include the actual help documentation or usage
  instructions for the tool.)\n\nTool homepage: https://github.com/Dfam-consortium/RepeatScout"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatscout:1.0.7--h7b50bb2_1
stdout: repeatscout_compare-out-to-gff.prl.out
