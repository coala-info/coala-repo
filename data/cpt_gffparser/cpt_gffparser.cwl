cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpt_gffparser
label: cpt_gffparser
doc: "A tool for parsing GFF files. (Note: The provided input text contains container
  build errors rather than the tool's help documentation, so specific arguments could
  not be extracted.)\n\nTool homepage: https://pypi.org/project/CPT-GFFParser/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpt_gffparser:1.2.2--pyh5e36f6f_0
stdout: cpt_gffparser.out
