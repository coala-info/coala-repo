cwlVersion: v1.2
class: CommandLineTool
baseCommand: draw_fusions.R
label: arriba_draw_fusions.r
doc: "A script to visualize fusions detected by Arriba in PDF format, showing genomic
  context, protein domains, and read support.\n\nTool homepage: https://github.com/suhrig/arriba"
inputs:
  - id: fusions
    type: File
    doc: Fusions file written by arriba (fusions.tsv).
    inputBinding:
      position: 101
      prefix: --fusions=
      separate: false
  - id: annotation
    type: File
    doc: Gene annotation in GTF format.
    inputBinding:
      position: 101
      prefix: --annotation=
      separate: false
  - id: alignments
    type:
      - 'null'
      - File
    doc: Coordinate-sorted, indexed BAM of the aligned reads, for coverage tracks.
    inputBinding:
      position: 101
      prefix: --alignments=
      separate: false
    secondaryFiles:
      - .bai
  - id: cytobands
    type:
      - 'null'
      - File
    doc: Cytobands file for the ideograms.
    inputBinding:
      position: 101
      prefix: --cytobands=
      separate: false
  - id: min_confidence_for_circos_plot
    type:
      - 'null'
      - string
    doc: Lowest confidence (low, medium, high) of fusions shown in the circos plot.
    inputBinding:
      position: 101
      prefix: --minConfidenceForCircosPlot=
      separate: false
  - id: protein_domains
    type:
      - 'null'
      - File
    doc: Protein domains in GFF3 format.
    inputBinding:
      position: 101
      prefix: --proteinDomains=
      separate: false
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Sample name printed on each page.
    inputBinding:
      position: 101
      prefix: --sampleName=
      separate: false
  - id: squish_introns
    type:
      - 'null'
      - boolean
    doc: Shrink introns to a fixed size (TRUE by default).
    inputBinding:
      position: 101
      prefix: --squishIntrons=
      separate: false
      valueFrom: "$(self ? 'TRUE' : 'FALSE')"
  - id: print_exon_labels
    type:
      - 'null'
      - boolean
    doc: Print exon numbers (TRUE by default).
    inputBinding:
      position: 101
      prefix: --printExonLabels=
      separate: false
      valueFrom: "$(self ? 'TRUE' : 'FALSE')"
  - id: render_3d_effect
    type:
      - 'null'
      - boolean
    doc: Draw a 3D effect on transcripts (TRUE by default).
    inputBinding:
      position: 101
      prefix: --render3dEffect=
      separate: false
      valueFrom: "$(self ? 'TRUE' : 'FALSE')"
  - id: plot_panels
    type:
      - 'null'
      - string
    doc: Comma-separated panels to draw (fusion,circos,domains,readcounts).
    inputBinding:
      position: 101
      prefix: --plotPanels=
      separate: false
  - id: pdf_width
    type:
      - 'null'
      - float
    doc: PDF page width in inches.
    inputBinding:
      position: 101
      prefix: --pdfWidth=
      separate: false
  - id: pdf_height
    type:
      - 'null'
      - float
    doc: PDF page height in inches.
    inputBinding:
      position: 101
      prefix: --pdfHeight=
      separate: false
  - id: color1
    type:
      - 'null'
      - string
    doc: Color of the first fusion partner.
    inputBinding:
      position: 101
      prefix: --color1=
      separate: false
  - id: color2
    type:
      - 'null'
      - string
    doc: Color of the second fusion partner.
    inputBinding:
      position: 101
      prefix: --color2=
      separate: false
  - id: merge_domains_overlapping_by
    type:
      - 'null'
      - float
    doc: Merge protein domains that overlap by this fraction.
    inputBinding:
      position: 101
      prefix: --mergeDomainsOverlappingBy=
      separate: false
  - id: optimize_domain_colors
    type:
      - 'null'
      - boolean
    doc: Give each protein domain a distinct color (FALSE by default).
    inputBinding:
      position: 101
      prefix: --optimizeDomainColors=
      separate: false
      valueFrom: "$(self ? 'TRUE' : 'FALSE')"
  - id: font_size
    type:
      - 'null'
      - float
    doc: Font size scaling factor.
    inputBinding:
      position: 101
      prefix: --fontSize=
      separate: false
  - id: font_family
    type:
      - 'null'
      - string
    doc: Font family.
    inputBinding:
      position: 101
      prefix: --fontFamily=
      separate: false
  - id: show_intergenic_vicinity
    type:
      - 'null'
      - string
    doc: Show genes in this many bp (or closestGene/closestProteinCodingGene) around intergenic breakpoints.
    inputBinding:
      position: 101
      prefix: --showIntergenicVicinity=
      separate: false
  - id: transcript_selection
    type:
      - 'null'
      - string
    doc: Transcript to draw (provided, canonical, coverage).
    inputBinding:
      position: 101
      prefix: --transcriptSelection=
      separate: false
  - id: fixed_scale
    type:
      - 'null'
      - int
    doc: Draw all fusions on the same scale of this many bp.
    inputBinding:
      position: 101
      prefix: --fixedScale=
      separate: false
  - id: coverage_range
    type:
      - 'null'
      - string
    doc: Maximum of the coverage axis (one value, or two separated by a comma).
    inputBinding:
      position: 101
      prefix: --coverageRange=
      separate: false
  - id: output_path
    type: string
    doc: Output PDF file
    inputBinding:
      position: 102
      prefix: --output=
      separate: false
outputs:
  - id: output
    type: File
    doc: PDF with one page per fusion
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arriba:2.5.1--h87b9561_0
