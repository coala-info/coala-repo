cwlVersion: v1.2
class: CommandLineTool
baseCommand: ultraplex
label: ultraplex
doc: "Ultra-fast demultiplexing of fastq files\n\nTool homepage: https://github.com/ulelab/ultraplex.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ultraplex:1.2.10--py39hbcbf7aa_0
stdout: ultraplex.out
