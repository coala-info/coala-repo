cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff3ToGenePred
label: ucsc-gff3togenepred
doc: "Convert a GFF3 file to a genePred file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_gff3
    type: File
    doc: Input GFF3 file
    inputBinding:
      position: 20
  - id: out_gp
    type: string
    doc: Output genePred file name
    inputBinding:
      position: 21
  - id: warn_and_continue
    type: ['null', boolean]
    doc: On bad genePreds being created, put out a warning but continue
    inputBinding:
      prefix: -warnAndContinue
      position: 1
  - id: use_name
    type: ['null', boolean]
    doc: Use the 'name' tag as the name, if present
    inputBinding:
      prefix: -useName
      position: 2
  - id: rna_name_attr
    type: ['null', string]
    doc: If this attribute exists on an RNA record, use it as the genePred name column
    inputBinding:
      prefix: -rnaNameAttr=
      separate: false
      position: 3
  - id: gene_name_attr
    type: ['null', string]
    doc: If this attribute exists on a gene record, use it as the genePred name2 column
    inputBinding:
      prefix: -geneNameAttr=
      separate: false
      position: 4
  - id: attrs_out
    type: ['null', string]
    doc: Output attributes of the mRNA record to this file (per genePred row, derived from GFF3 attributes)
    inputBinding:
      prefix: -attrsOut=
      separate: false
      position: 5
  - id: process_all_gene_children
    type: ['null', boolean]
    doc: Output a genePred for all children of a gene regardless of feature
    inputBinding:
      prefix: -processAllGeneChildren
      position: 6
  - id: unprocessed_roots_out
    type: ['null', string]
    doc: Output GFF3 root records that were not used (not a valid GFF3 file)
    inputBinding:
      prefix: -unprocessedRootsOut=
      separate: false
      position: 7
  - id: bad
    type: ['null', string]
    doc: Output genePreds that fail checks to this file
    inputBinding:
      prefix: -bad=
      separate: false
      position: 8
  - id: max_parse_errors
    type: ['null', int]
    doc: Maximum number of parsing errors before aborting; negative allows unlimited (default 50)
    inputBinding:
      prefix: -maxParseErrors=
      separate: false
      position: 9
  - id: max_convert_errors
    type: ['null', int]
    doc: Maximum number of conversion errors before aborting; negative allows unlimited (default 50)
    inputBinding:
      prefix: -maxConvertErrors=
      separate: false
      position: 10
  - id: honor_start_stop_codons
    type: ['null', boolean]
    doc: Only set CDS start/stop status to complete if there are corresponding start_stop codon records
    inputBinding:
      prefix: -honorStartStopCodons
      position: 11
  - id: default_cds_status_to_unknown
    type: ['null', boolean]
    doc: Default the CDS status to unknown rather than complete
    inputBinding:
      prefix: -defaultCdsStatusToUnknown
      position: 12
  - id: allow_minimal_genes
    type: ['null', boolean]
    doc: Convert genes with exons as direct children and stand-alone genes with no exon or transcript children
    inputBinding:
      prefix: -allowMinimalGenes
      position: 13
  - id: refseq_hacks
    type: ['null', boolean]
    doc: Enable hacks to make RefSeq conversion work (turns on -useName, -allowMinimalGenes, -processAllGeneChildren)
    inputBinding:
      prefix: -refseqHacks
      position: 14
outputs:
  - id: genepred
    type: File
    doc: Output genePred file
    outputBinding:
      glob: $(inputs.out_gp)
  - id: attrs_out_file
    type: ['null', File]
    doc: Output attributes of the mRNA record to this file (per genePred row, derived from GFF3 attributes)
    outputBinding:
      glob: $(inputs.attrs_out)
  - id: unprocessed_roots_out_file
    type: ['null', File]
    doc: Output GFF3 root records that were not used (not a valid GFF3 file)
    outputBinding:
      glob: $(inputs.unprocessed_roots_out)
  - id: bad_file
    type: ['null', File]
    doc: Output genePreds that fail checks to this file
    outputBinding:
      glob: $(inputs.bad)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-gff3togenepred:482--h0b57e2e_0
