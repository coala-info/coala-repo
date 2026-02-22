cwlVersion: v1.2
class: CommandLineTool
baseCommand: anarci
label: anarci
doc: "ANARCI: Antibody Numbering and Antigen Receptor ClassIfication. (Note: The provided
  text appears to be a container build error log rather than help text, so no arguments
  could be extracted.)\n\nTool homepage: http://opig.stats.ox.ac.uk/webapps/newsabdab/sabpred/anarci/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anarci:2024.05.21--pyhdfd78af_0
stdout: anarci.out
