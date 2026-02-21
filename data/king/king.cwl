cwlVersion: v1.2
class: CommandLineTool
baseCommand: king
label: king
doc: "Kinship-based Inference for Gwas (KING) is a toolset to explore family relationship
  and population structure in GWAS data. (Note: The provided text is a container runtime
  error log and does not contain usage instructions or argument definitions.)\n\n
  Tool homepage: http://people.virginia.edu/~wc9c/KING/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/king:v2.23.161103dfsg1-3-deb_cv1
stdout: king.out
