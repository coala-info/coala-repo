cwlVersion: v1.2
class: CommandLineTool
baseCommand: rust-mdbg_gfa2fasta.sh
label: rust-mdbg_gfa2fasta.sh
doc: "A script to convert GFA (Graphical Fragment Assembly) files to FASTA format,
  typically used in the context of the rust-mdbg assembler.\n\nTool homepage: https://github.com/ekimb/rust-mdbg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-mdbg:1.0.1--h4ac6f70_3
stdout: rust-mdbg_gfa2fasta.sh.out
