cwlVersion: v1.2
class: CommandLineTool
baseCommand: bppsuite
label: bppsuite
doc: "Bioinformatics Phylogenetics and Evolution suite (Note: The provided text contains
  system error messages regarding disk space and container image retrieval rather
  than tool help text).\n\nTool homepage: https://github.com/BioPP/bppsuite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bppsuite:v2.4.1-1-deb_cv1
stdout: bppsuite.out
