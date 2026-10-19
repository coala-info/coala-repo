cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ragtag.py
  - agp2fa
label: ragtag_agp2fa
doc: "Build sequences in FASTA format from an AGP v2.1 file; the FASTA is written\
  \ to standard output.\n\nTool homepage: https://github.com/malonge/RagTag"
inputs:
  - id: scaffolds_agp
    type: File
    doc: AGP v2.1 file
    inputBinding:
      position: 1
  - id: components
    type: File
    doc: component FASTA file (can be uncompressed or bgzipped) (staged writable because
      the tool writes a .fai index beside it)
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
outputs:
  - id: scaffolds_fasta
    type: stdout
    doc: FASTA sequences built from the AGP file
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.components)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
stdout: ragtag_agp2fa.fa
