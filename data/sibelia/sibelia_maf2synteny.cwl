cwlVersion: v1.2
class: CommandLineTool
baseCommand: maf2synteny
label: sibelia_maf2synteny
doc: "A tool for processing Multiple Alignment Format (MAF) files into synteny blocks.
  (Note: The provided text contains only container runtime error logs and does not
  include the tool's help documentation; therefore, no arguments could be extracted.)\n
  \nTool homepage: https://github.com/bioinf/Sibelia"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sibelia:3.0.7--0
stdout: sibelia_maf2synteny.out
