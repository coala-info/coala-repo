cwlVersion: v1.2
class: CommandLineTool
baseCommand: rcorrector
label: rcorrector
doc: "A k-mer based error correction method for Illumina RNA-seq reads.\n\nTool homepage:
  https://github.com/mourisl/Rcorrector/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rcorrector:1.0.7--pl5321h5ca1c30_2
stdout: rcorrector.out
