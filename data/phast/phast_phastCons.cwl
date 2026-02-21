cwlVersion: v1.2
class: CommandLineTool
baseCommand: phastCons
label: phast_phastCons
doc: "Phylogenetic Analysis with Space/Time Models (PHAST) - phastCons. (Note: The
  provided help text contains container execution errors and does not list specific
  tool arguments.)\n\nTool homepage: http://compgen.cshl.edu/phast/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.6--h93e12ee_0
stdout: phast_phastCons.out
