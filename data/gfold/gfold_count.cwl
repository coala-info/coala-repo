cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfold_count
label: gfold_count
doc: "Generalized fold change for ranking differentially expressed genes from RNA-seq
  data.\n\nTool homepage: https://github.com/nickgerace/gfold"
inputs:
  - id: annotation_file
    type: File
    doc: Annotation file (GTF format)
    inputBinding:
      position: 101
      prefix: -ann
  - id: tag_file
    type: File
    doc: SAM file containing mapped reads
    inputBinding:
      position: 101
      prefix: -tag
outputs:
  - id: output_file
    type: File
    doc: Output file for read counts
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfold:1.1.4--gsl1.16_1
