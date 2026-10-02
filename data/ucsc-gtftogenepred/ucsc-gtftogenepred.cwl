cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtfToGenePred
label: ucsc-gtftogenepred
doc: convert a GTF file to a genePred
inputs:
  - id: gtf
    type: File
    doc: Input GTF file
    inputBinding:
      position: 1
  - id: gene_pred
    type: string
    doc: Output genePred file
    inputBinding:
      position: 2
  - id: gene_pred_ext
    type:
      - 'null'
      - boolean
    doc: create a extended genePred, including frame information and gene name
    inputBinding:
      position: 103
      prefix: -genePredExt
  - id: all_errors
    type:
      - 'null'
      - boolean
    doc: skip groups with errors rather than aborting. Useful for getting 
      infomation about as many errors as possible.
    inputBinding:
      position: 103
      prefix: -allErrors
  - id: ignore_groups_without_exons
    type:
      - 'null'
      - boolean
    doc: skip groups contain no exons rather than generate an error.
    inputBinding:
      position: 103
      prefix: -ignoreGroupsWithoutExons
  - id: info_out
    type:
      - 'null'
      - string
    doc: write a file with information on each transcript
    inputBinding:
      position: 103
      prefix: -infoOut=
      separate: false
  - id: source_prefix
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -sourcePrefix=
          separate: false
    doc: only process entries where the source name has the specified prefix. 
      May be repeated.
    inputBinding:
      position: 103
  - id: implied_stop_after_cds
    type:
      - 'null'
      - boolean
    doc: implied stop codon in after CDS
    inputBinding:
      position: 103
      prefix: -impliedStopAfterCds
  - id: simple
    type:
      - 'null'
      - boolean
    doc: just check column validity, not hierarchy, resulting genePred may be 
      damaged
    inputBinding:
      position: 103
      prefix: -simple
  - id: gene_name_as_name2
    type:
      - 'null'
      - boolean
    doc: if specified, use gene_name for the name2 field instead of gene_id.
    inputBinding:
      position: 103
      prefix: -geneNameAsName2
  - id: include_version
    type:
      - 'null'
      - boolean
    doc: it gene_version and/or transcript_version attributes exist, include the
      version in the corresponding identifiers.
    inputBinding:
      position: 103
      prefix: -includeVersion
outputs:
  - id: out_gene_pred
    type: File
    doc: Output genePred file
    outputBinding:
      glob: $(inputs.gene_pred)
  - id: output_info_out
    type:
      - 'null'
      - File
    doc: write a file with information on each transcript
    outputBinding:
      glob: $(inputs.info_out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-gtftogenepred:482--h0b57e2e_0
s:url: https://hgdownload.cse.ucsc.edu/admin/exe
$namespaces:
  s: https://schema.org/
