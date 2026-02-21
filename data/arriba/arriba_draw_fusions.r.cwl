cwlVersion: v1.2
class: CommandLineTool
baseCommand: arriba_draw_fusions.r
label: arriba_draw_fusions.r
doc: "A script to visualize fusions detected by Arriba in PDF format, showing genomic
  context, protein domains, and read support.\n\nTool homepage: https://github.com/suhrig/arriba"
inputs:
  - id: annotation
    type: File
    doc: Gene annotation file in GTF format
    inputBinding:
      position: 101
      prefix: --annotation
  - id: bam
    type: File
    doc: BAM file containing aligned reads
    inputBinding:
      position: 101
      prefix: --bam
  - id: cytobands
    type:
      - 'null'
      - File
    doc: Coordinates of Giemsa-stained cytology bands
    inputBinding:
      position: 101
      prefix: --cytobands
  - id: fusions
    type: File
    doc: File containing fusion predictions (fusions.tsv)
    inputBinding:
      position: 101
      prefix: --fusions
  - id: max_fusions
    type:
      - 'null'
      - int
    doc: Maximum number of fusions to render
    inputBinding:
      position: 101
      prefix: --maxFusions
  - id: min_confidence_for_circos
    type:
      - 'null'
      - float
    doc: Minimum confidence level to include a fusion in the circos plot
    inputBinding:
      position: 101
      prefix: --minConfidenceForCircos
  - id: protein_domains
    type:
      - 'null'
      - File
    doc: Protein domain database in GFF3 format
    inputBinding:
      position: 101
      prefix: --proteinDomains
  - id: render_all
    type:
      - 'null'
      - boolean
    doc: Render all fusions, not just those passing filters
    inputBinding:
      position: 101
      prefix: --renderAll
  - id: squish
    type:
      - 'null'
      - boolean
    doc: Squish overlapping reads in the alignment view
    inputBinding:
      position: 101
      prefix: --squish
outputs:
  - id: output
    type: File
    doc: Output file in PDF format
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arriba:2.5.1--h87b9561_0
