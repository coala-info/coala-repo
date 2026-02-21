cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtfToGenePred
label: ucsc-genepredtoprot_gtfToGenePred
doc: "Convert a GTF file to a genePred file.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: gtf_file
    type: File
    doc: Input GTF file
    inputBinding:
      position: 1
  - id: all_errors
    type:
      - 'null'
      - boolean
    doc: Report all errors
    inputBinding:
      position: 102
      prefix: -allErrors
  - id: gene_pred_ext
    type:
      - 'null'
      - boolean
    doc: Create a genePredExt format file
    inputBinding:
      position: 102
      prefix: -genePredExt
  - id: ignore_groups_without_exons
    type:
      - 'null'
      - boolean
    doc: Skip groups without exons
    inputBinding:
      position: 102
      prefix: -ignoreGroupsWithoutExons
  - id: include_version
    type:
      - 'null'
      - boolean
    doc: Include version in gene name
    inputBinding:
      position: 102
      prefix: -includeVersion
  - id: simple
    type:
      - 'null'
      - boolean
    doc: Use simple genePred format
    inputBinding:
      position: 102
      prefix: -simple
outputs:
  - id: output_genepred
    type: File
    doc: Output genePred file
    outputBinding:
      glob: '*.out'
  - id: info_out
    type:
      - 'null'
      - File
    doc: Write info to file
    outputBinding:
      glob: $(inputs.info_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredtoprot:482--h0b57e2e_0
