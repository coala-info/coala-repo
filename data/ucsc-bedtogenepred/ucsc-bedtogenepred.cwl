cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedToGenePred
label: ucsc-bedtogenepred
doc: "Convert bed format files to genePred format. If BED has at least 12 columns,
  then a genePred with blocks is created. Otherwise single-exon genePreds are created.\n\
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: bed_file
    type: File
    doc: Input BED file.
    inputBinding:
      position: 1
  - id: gene_pred_file
    type: string
    doc: Name of the output genePred file.
    inputBinding:
      position: 2
outputs:
  - id: output_genepred
    type: File
    doc: genePred file.
    outputBinding:
      glob: $(inputs.gene_pred_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedtogenepred:482--h0b57e2e_0
