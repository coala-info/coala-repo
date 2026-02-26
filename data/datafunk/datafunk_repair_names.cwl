cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - repair_names
label: datafunk_repair_names
doc: "Repair FASTA headers using a phylogenetic tree.\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: tree
    type: File
    doc: Input phylogenetic tree file (e.g., Newick format)
    inputBinding:
      position: 101
      prefix: --tree
outputs:
  - id: out
    type: File
    doc: Output file for repaired FASTA
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
