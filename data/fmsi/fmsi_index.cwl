cwlVersion: v1.2
class: CommandLineTool
baseCommand: fmsi_index
label: fmsi_index
doc: "Index a masked superstring for fmsi.\n\nTool homepage: https://github.com/OndrejSladky/fmsi"
inputs:
  - id: masked_superstring_input
    type: File
    doc: Path to the masked superstring
    inputBinding:
      position: 1
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: size of k-mers
    inputBinding:
      position: 102
      prefix: -k
  - id: no_klcp
    type:
      - 'null'
      - boolean
    doc: do not compute the kLCP array used for faster streaming queries.
    inputBinding:
      position: 102
      prefix: -x
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fmsi:0.4.0--h077b44d_0
stdout: fmsi_index.out
