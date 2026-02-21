cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-rna-seq-training
label: galaxy-rna-seq-training
doc: A tool for RNA-seq training, specifically focused on sRNA-seq tutorials as indicated
  by the container image metadata.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/galaxy-rna-seq-training:sRNA-seq-tutorial
stdout: galaxy-rna-seq-training.out
