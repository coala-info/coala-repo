cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ragtag.py
  - updategff
label: ragtag_updategff
doc: "Update gff intervals given a RagTag AGP file; the updated GFF is written to\
  \ standard output.\n\nTool homepage: https://github.com/malonge/RagTag"
inputs:
  - id: correction
    type:
      - 'null'
      - boolean
    doc: update for misassembly correction (ragtag.correction.agp)
    inputBinding:
      position: 101
      prefix: -c
  - id: genes_gff
    type: File
    doc: gff file
    inputBinding:
      position: 1
  - id: agp
    type: File
    doc: agp file
    inputBinding:
      position: 2
outputs:
  - id: updated_gff
    type: stdout
    doc: Updated GFF file
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
stdout: ragtag_updategff.gff
