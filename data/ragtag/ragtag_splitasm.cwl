cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ragtag.py
  - splitasm
label: ragtag_splitasm
doc: "Split sequences at gaps and write the split FASTA to standard output and an\
  \ AGP file.\n\nTool homepage: https://github.com/malonge/RagTag"
inputs:
  - id: assembly
    type: File
    doc: assembly fasta file (uncompressed or bgzipped) (staged writable because the
      tool writes a .fai index beside it)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: min_gap_size
    type:
      - 'null'
      - int
    doc: minimum gap size [0]
    inputBinding:
      position: 101
      prefix: -n
  - id: output_agp
    type:
      - 'null'
      - string
    doc: output AGP file path [./ragtag.splitasm.agp]
    default: ragtag.splitasm.agp
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: split_fasta
    type: stdout
    doc: Split sequences in FASTA format
  - id: agp_out
    type: File
    doc: AGP file describing the split
    outputBinding:
      glob: $(inputs.output_agp)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.assembly)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
stdout: ragtag_splitasm.fa
