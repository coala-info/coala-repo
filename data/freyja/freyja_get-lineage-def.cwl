cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - freyja
  - get-lineage-def
label: freyja_get-lineage-def
doc: "Get the mutations defining a LINEAGE of interest from provided barcodes\n\n\
  Tool homepage: https://github.com/andersen-lab/Freyja"
inputs:
  - id: lineage
    type: string
    doc: LINEAGE of interest
    inputBinding:
      position: 1
  - id: annot
    type:
      - 'null'
      - string
    doc: Path to annotation file in gff3 format. If included, shows amino acid 
      mutations.
    inputBinding:
      position: 102
      prefix: --annot
  - id: barcodes
    type:
      - 'null'
      - string
    doc: Path to custom barcode file
    inputBinding:
      position: 102
      prefix: --barcodes
  - id: ref
    type:
      - 'null'
      - File
    doc: Reference file in fasta format. Required to display amino acid 
      mutations
    inputBinding:
      position: 102
      prefix: --ref
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file to save lineage definition. Defaults to stdout.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
