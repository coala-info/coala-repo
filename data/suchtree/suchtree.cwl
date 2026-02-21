cwlVersion: v1.2
class: CommandLineTool
baseCommand: suchtree
label: suchtree
doc: "A tool for phylogenetic tree comparison and analysis (Note: The provided help
  text contains only container build logs and error messages, so specific arguments
  could not be extracted).\n\nTool homepage: https://github.com/ryneches/SuchTree/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/suchtree:1.3--py39hbcbf7aa_0
stdout: suchtree.out
