cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrnaToGene
label: ucsc-mrnatogene
doc: "convert PSL alignments of mRNAs to gene annotations\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: psl
    type: File
    doc: PSL file (or a table in a database when -db is used)
    inputBinding:
      position: 1
  - id: gene_pred_file
    type: string
    doc: Output genePred file name
    inputBinding:
      position: 2
  - id: db
    type: ['null', string]
    doc: "get PSLs and CDS from this database, psl specifies the table."
    inputBinding:
      position: 101
      prefix: -db=
      separate: false
  - id: cds_db
    type: ['null', string]
    doc: "get CDS from this database, psl is a file."
    inputBinding:
      position: 101
      prefix: -cdsDb=
      separate: false
  - id: cds_file
    type: ['null', File]
    doc: "get CDS from this file, psl is a file. File is tab separate with name as the first column and NCBI CDS the second"
    inputBinding:
      position: 101
      prefix: -cdsFile=
      separate: false
  - id: insert_merge_size
    type: ['null', int]
    doc: "Merge inserts (gaps) no larger than this many bases. A negative size disables merging of blocks. Defaults to 8 unless -cdsMergeSize or -utrMergeSize are specified."
    inputBinding:
      position: 101
      prefix: -insertMergeSize=
      separate: false
  - id: small_insert_size
    type: ['null', int]
    doc: "alias for -insertMergeSize"
    inputBinding:
      position: 101
      prefix: -smallInsertSize=
      separate: false
  - id: cds_merge_size
    type: ['null', int]
    doc: "merge gaps in CDS no larger than this size. A negative value disables."
    inputBinding:
      position: 101
      prefix: -cdsMergeSize=
      separate: false
  - id: cds_merge_mod3
    type: ['null', boolean]
    doc: "only merge CDS gaps if they mod 3"
    inputBinding:
      position: 101
      prefix: -cdsMergeMod3
  - id: utr_merge_size
    type: ['null', int]
    doc: "merge gaps in UTR no larger than this size. A negative value disables."
    inputBinding:
      position: 101
      prefix: -utrMergeSize=
      separate: false
  - id: require_utr
    type: ['null', boolean]
    doc: "Drop sequences that don't have both 5' and 3' UTR annotated."
    inputBinding:
      position: 101
      prefix: -requireUtr
  - id: gene_pred_ext
    type: ['null', boolean]
    doc: "create a extended genePred, including frame information."
    inputBinding:
      position: 101
      prefix: -genePredExt
  - id: all_cds
    type: ['null', boolean]
    doc: "consider PSL to be all CDS."
    inputBinding:
      position: 101
      prefix: -allCds
  - id: no_cds
    type: ['null', boolean]
    doc: "consider PSL to not contain any CDS."
    inputBinding:
      position: 101
      prefix: -noCds
  - id: keep_invalid
    type: ['null', boolean]
    doc: "Keep sequences with invalid CDS."
    inputBinding:
      position: 101
      prefix: -keepInvalid
  - id: quiet
    type: ['null', boolean]
    doc: "Don't print info about dropped sequences."
    inputBinding:
      position: 101
      prefix: -quiet
  - id: ignore_uniq_suffix
    type: ['null', boolean]
    doc: "ignore all characters after last `-' in qName when looking up CDS. Used when a suffix has been added to make qName unique."
    inputBinding:
      position: 101
      prefix: -ignoreUniqSuffix
outputs:
  - id: out_gene_pred_file
    type: File
    doc: Output genePred file
    outputBinding:
      glob: $(inputs.gene_pred_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mrnatogene:482--h0b57e2e_0
