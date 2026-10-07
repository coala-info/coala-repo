cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff3ToGenePred
label: comparative-annotation-toolkit_gff3ToGenePred
doc: "convert a GFF3 file to a genePred file\n\nTool homepage: https://github.com/ComparativeGenomicsToolkit/Comparative-Annotation-Toolkit"
inputs:
  - id: input_gff3
    type: File
    doc: Input GFF3 file
    inputBinding:
      position: 1
  - id: output_gp_path
    type: string
    doc: Output genePred file name
    inputBinding:
      position: 2
  - id: allow_minimal_genes
    type:
      - 'null'
      - boolean
    doc: normally this programs assumes that genes contains transcripts which 
      contain exons. If this option is specified, genes with exons as direct 
      children of genes and stand alone genes with no exon or transcript 
      children will be converted.
    inputBinding:
      position: 102
      prefix: -allowMinimalGenes
  - id: default_cds_status_to_unknown
    type:
      - 'null'
      - boolean
    doc: default the CDS status to unknown rather than complete.
    inputBinding:
      position: 102
      prefix: -defaultCdsStatusToUnknown
  - id: gene_name_attr
    type:
      - 'null'
      - string
    doc: If this attribute exists on a gene record, use it as the genePred name2
      column
    inputBinding:
      position: 102
      prefix: -geneNameAttr=
      separate: false
  - id: honor_start_stop_codons
    type:
      - 'null'
      - boolean
    doc: only set CDS start/stop status to complete if there are corresponding 
      start_stop codon records
    inputBinding:
      position: 102
      prefix: -honorStartStopCodons
  - id: max_convert_errors
    type:
      - 'null'
      - int
    doc: Maximum number of conversion errors before aborting. A negative value 
      will allow an unlimited number of errors.
    inputBinding:
      position: 102
      prefix: -maxConvertErrors=
      separate: false
  - id: max_parse_errors
    type:
      - 'null'
      - int
    doc: Maximum number of parsing errors before aborting. A negative value will
      allow an unlimited number of errors.
    inputBinding:
      position: 102
      prefix: -maxParseErrors=
      separate: false
  - id: process_all_gene_children
    type:
      - 'null'
      - boolean
    doc: output genePred for all children of a gene regardless of feature
    inputBinding:
      position: 102
      prefix: -processAllGeneChildren
  - id: refseq_hacks
    type:
      - 'null'
      - boolean
    doc: 'enable various hacks to make RefSeq conversion work: This turns on -useName,
      -allowMinimalGenes, and -processAllGeneChildren. It try harder to find an accession
      in attributes'
    inputBinding:
      position: 102
      prefix: -refseqHacks
  - id: rna_name_attr
    type:
      - 'null'
      - string
    doc: If this attribute exists on an RNA record, use it as the genePred name 
      column
    inputBinding:
      position: 102
      prefix: -rnaNameAttr=
      separate: false
  - id: use_name
    type:
      - 'null'
      - boolean
    doc: rather than using 'id' as name, use the 'name' tag
    inputBinding:
      position: 102
      prefix: -useName
  - id: warn_and_continue
    type:
      - 'null'
      - boolean
    doc: on bad genePreds being created, put out warning but continue
    inputBinding:
      position: 102
      prefix: -warnAndContinue
  - id: attrs_out_path
    type:
      - 'null'
      - string
    doc: =file - output attributes of mRNA record to file.  These are 
      per-genePred row,
    inputBinding:
      position: 103
      prefix: -attrsOut=
      separate: false
  - id: bad_path
    type:
      - 'null'
      - string
    doc: =file   - output genepreds that fail checks to file
    inputBinding:
      position: 104
      prefix: -bad=
      separate: false
  - id: unprocessed_roots_out_path
    type:
      - 'null'
      - string
    doc: =file - output GFF3 root records that were not used.  This will not be 
      a
    inputBinding:
      position: 105
      prefix: -unprocessedRootsOut=
      separate: false
outputs:
  - id: output_gp
    type: File
    doc: Output genePred file
    outputBinding:
      glob: $(inputs.output_gp_path)
  - id: attrs_out
    type:
      - 'null'
      - File
    doc: output attributes of mRNA record to file. These are per-genePred row, 
      not per-GFF3 record. Thery are derived from GFF3 attributes, not the 
      attributes themselves.
    outputBinding:
      glob: $(inputs.attrs_out_path)
  - id: unprocessed_roots_out
    type:
      - 'null'
      - File
    doc: output GFF3 root records that were not used. This will not be a valid 
      GFF3 file. It's expected that many non-root records will not be used and 
      they are not reported.
    outputBinding:
      glob: $(inputs.unprocessed_roots_out_path)
  - id: bad
    type:
      - 'null'
      - File
    doc: output genepreds that fail checks to file
    outputBinding:
      glob: $(inputs.bad_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/comparative-annotation-toolkit:0.1--pyh2407274_1
