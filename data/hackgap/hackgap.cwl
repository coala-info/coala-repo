cwlVersion: v1.2
class: CommandLineTool
baseCommand: hackgap
label: hackgap
doc: "Haplotype-aware assembly of polyploid genomes (Note: The provided text is a
  container runtime error log and does not contain usage or help information).\n\n
  Tool homepage: https://gitlab.com/rahmannlab/hackgap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hackgap:1.0.1--pyhdfd78af_0
stdout: hackgap.out
