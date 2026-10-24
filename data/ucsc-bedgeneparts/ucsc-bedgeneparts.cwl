cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedGeneParts
label: ucsc-bedgeneparts
doc: "Given a bed, spit out promoter, first exon, or all introns.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: part
    type: string
    doc: "Part to extract: 'exons', 'firstExon', 'introns', 'promoter', 'firstCodingSplice'
      or 'secondCodingSplice'."
    inputBinding:
      position: 1
  - id: in_bed
    type: File
    doc: Input BED file (genes with blocks).
    inputBinding:
      position: 2
  - id: out_bed
    type: string
    doc: Name of the output BED file.
    inputBinding:
      position: 3
  - id: pro_start
    type:
      - 'null'
      - int
    doc: Start of promoter relative to txStart (default -100).
    inputBinding:
      position: 0
      prefix: -proStart=
      separate: false
  - id: pro_end
    type:
      - 'null'
      - int
    doc: End of promoter relative to txStart (default 50).
    inputBinding:
      position: 0
      prefix: -proEnd=
      separate: false
outputs:
  - id: output_bed
    type: File
    doc: Output BED file with the requested gene parts.
    outputBinding:
      glob: $(inputs.out_bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedgeneparts:482--h0b57e2e_0
