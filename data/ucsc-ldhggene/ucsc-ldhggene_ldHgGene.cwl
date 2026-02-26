cwlVersion: v1.2
class: CommandLineTool
baseCommand: ldHgGene
label: ucsc-ldhggene_ldHgGene
doc: "load database with gene predictions from a gff file.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: database
    type: string
    doc: Database name
    inputBinding:
      position: 1
  - id: table
    type: string
    doc: Table name
    inputBinding:
      position: 2
  - id: gff_files
    type:
      type: array
      items: File
    doc: Input GFF file(s)
    inputBinding:
      position: 3
  - id: add_bin_column
    type:
      - 'null'
      - boolean
    doc: Add bin column (now the default)
    inputBinding:
      position: 104
      prefix: -bin
  - id: create_extended_gene_pred
    type:
      - 'null'
      - boolean
    doc: create a extended genePred, including frame information and gene name
    inputBinding:
      position: 104
      prefix: -genePredExt
  - id: exon_type
    type:
      - 'null'
      - string
    doc: Sets type field for exons to specific value
    inputBinding:
      position: 104
      prefix: -exon
  - id: force_utr
    type:
      - 'null'
      - boolean
    doc: Forces whole prediction to be UTR
    inputBinding:
      position: 104
      prefix: -noncoding
  - id: implied_stop_after_cds
    type:
      - 'null'
      - boolean
    doc: implied stop codon in GFF/GTF after CDS
    inputBinding:
      position: 104
      prefix: -impliedStopAfterCds
  - id: input_is_gene_pred_tab
    type:
      - 'null'
      - boolean
    doc: input is already in genePredTab format
    inputBinding:
      position: 104
      prefix: -predTab
  - id: input_is_gtf
    type:
      - 'null'
      - boolean
    doc: input is GTF, stop codon is not in CDS
    inputBinding:
      position: 104
      prefix: -gtf
  - id: no_binning
    type:
      - 'null'
      - boolean
    doc: don't add binning (you probably don't want this)
    inputBinding:
      position: 104
      prefix: -nobin
  - id: old_table
    type:
      - 'null'
      - boolean
    doc: Don't overwrite what's already in table
    inputBinding:
      position: 104
      prefix: -oldTable
  - id: require_cds
    type:
      - 'null'
      - boolean
    doc: discard genes that don't have CDS annotation
    inputBinding:
      position: 104
      prefix: -requireCDS
outputs:
  - id: output_gene_pred_file
    type:
      - 'null'
      - File
    doc: write output, in genePred format, instead of loading table. Database is
      ignored.
    outputBinding:
      glob: $(inputs.output_gene_pred_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-ldhggene:482--h0b57e2e_0
