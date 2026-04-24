cwlVersion: v1.2
class: CommandLineTool
baseCommand: berokka
label: berokka
doc: "Trim and clean prokaryotic gene overlaps\n\nTool homepage: https://github.com/tseemann/berokka"
inputs:
  - id: input_contigs
    type: File
    doc: Input contigs in FASTA format
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing output directory
    inputBinding:
      position: 102
      prefix: --force
  - id: minlen
    type:
      - 'null'
      - int
    doc: Minimum length of contig to keep
    inputBinding:
      position: 102
      prefix: --minlen
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/berokka:0.2.3--0
