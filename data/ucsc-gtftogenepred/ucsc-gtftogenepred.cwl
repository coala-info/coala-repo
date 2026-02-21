cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtfToGenePred
label: ucsc-gtftogenepred
doc: "Convert a GTF file to a genePred file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_gtf
    type: File
    doc: Input GTF file
    inputBinding:
      position: 1
  - id: all_errors
    type:
      - 'null'
      - boolean
    doc: Report all errors rather than just the first.
    inputBinding:
      position: 102
      prefix: -allErrors
  - id: gene_pred_ext
    type:
      - 'null'
      - boolean
    doc: Create a genePredExt format file, including frame information and other extra
      fields.
    inputBinding:
      position: 102
      prefix: -genePredExt
  - id: ignore_groups_without_exons
    type:
      - 'null'
      - boolean
    doc: Ignore GTF groups that do not contain any exons.
    inputBinding:
      position: 102
      prefix: -ignoreGroupsWithoutExons
  - id: implied_stop
    type:
      - 'null'
      - boolean
    doc: The stop codon is implied and not explicitly defined in the GTF.
    inputBinding:
      position: 102
      prefix: -impliedStop
  - id: include_version
    type:
      - 'null'
      - boolean
    doc: Include version in the geneId and transcriptId.
    inputBinding:
      position: 102
      prefix: -includeVersion
  - id: source_out
    type:
      - 'null'
      - boolean
    doc: Include the source field in the output.
    inputBinding:
      position: 102
      prefix: -sourceOut
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
    doc: Write information about the conversion to the specified file.
    outputBinding:
      glob: $(inputs.info_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-gtftogenepred:482--h0b57e2e_0
