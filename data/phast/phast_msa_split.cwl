cwlVersion: v1.2
class: CommandLineTool
baseCommand: phast_msa_split
label: phast_msa_split
doc: "A tool from the PHAST (Phylogenetic Analysis with Space/Time Models) package
  for splitting multiple sequence alignments. (Note: The provided help text contains
  only container runtime error messages and no usage information.)\n\nTool homepage:
  http://compgen.cshl.edu/phast/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.6--h93e12ee_0
stdout: phast_msa_split.out
