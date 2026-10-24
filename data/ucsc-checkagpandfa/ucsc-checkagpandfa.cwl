cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkAgpAndFa
label: ucsc-checkagpandfa
doc: "Take an agp file and a fasta file and ensure that they are in synch. The fasta
  file can be a .2bit file. If it is a .fa file then sequences must appear in the
  same order in the agp and fasta files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_agp
    type: File
    doc: Input agp file
    inputBinding:
      position: 1
  - id: in_fa
    type: File
    doc: Input fasta file or 2bit file
    inputBinding:
      position: 2
  - id: exclude
    type: ['null', string]
    doc: Ignore this sequence (e.g. chrM for which we usually get sequence from
      GenBank but do not have an agp)
    inputBinding:
      position: 0
      prefix: -exclude=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Messages of the check
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-checkagpandfa:482--h0b57e2e_0
stdout: ucsc-checkagpandfa.out
