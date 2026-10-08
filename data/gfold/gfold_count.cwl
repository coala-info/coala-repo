cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gfold
  - count
label: gfold_count
doc: "Given the gene annotation in GTF/GPF/BED format and mapped short reads in SAM/BED
  format, count the number of reads mapped to each gene (GFOLD, generalized fold
  change for ranking differentially expressed genes from RNA-seq data).\n\nTool homepage:
  https://zhanglab.tongji.edu.cn/softwares/GFOLD/index.html"
inputs:
  - id: annotation_file
    type: File
    doc: Gene annotation file in GTF/GPF/BED format
    inputBinding:
      position: 1
      prefix: -ann
  - id: annotation_format
    type:
      - 'null'
      - string
    doc: The format of gene annotation file (GTF, GPF or BED). Default GTF
    inputBinding:
      position: 1
      prefix: -annf
  - id: tag_file
    type: File
    doc: Short reads in SAM (or BED) format
    inputBinding:
      position: 1
      prefix: -tag
  - id: tag_format
    type:
      - 'null'
      - string
    doc: The format of short reads (SAM or BED). Default SAM
    inputBinding:
      position: 1
      prefix: -tagf
  - id: strand_specific
    type:
      - 'null'
      - string
    doc: Whether the sequencing data is strand specific (T or F). Default F
    inputBinding:
      position: 1
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - int
    doc: Verbose level. A larger value gives more information. Default 2
    inputBinding:
      position: 1
      prefix: -v
  - id: output_file_path
    type: string
    doc: The file for output
    inputBinding:
      position: 2
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: Read count per gene (GeneSymbol, GeneName, Read Count, Gene exon length, RPKM)
    outputBinding:
      glob: $(inputs.output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfold:1.1.4--gsl1.16_1
