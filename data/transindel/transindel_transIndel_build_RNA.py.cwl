cwlVersion: v1.2
class: CommandLineTool
baseCommand: transIndel_build_RNA.py
label: transindel_transIndel_build_RNA.py
doc: "Build a BAM file for indel calling from a BWA alignment of RNA-seq reads. Splice sites from the annotation are used to separate splicing from deletions.\n\nTool homepage: https://github.com/cauyrd/transIndel"
inputs:
  - id: input
    type: File
    doc: "Input BAM file"
    inputBinding:
      prefix: --input
  - id: output
    type: string
    doc: "Output BAM file"
    inputBinding:
      prefix: --output
  - id: ref
    type: File
    secondaryFiles:
      - pattern: '.fai'
        required: true
    doc: "reference genome used for analyzing RNA-seq data"
    inputBinding:
      prefix: --ref
  - id: gtf
    type: File
    doc: "gene annotation file used for analyzing RNA-seq data"
    inputBinding:
      prefix: --gtf
  - id: splice_bin
    type:
      - 'null'
      - int
    doc: "splice site half bin size (default: 20)"
    inputBinding:
      prefix: --splice_bin
  - id: mapq
    type:
      - 'null'
      - int
    doc: "minimal MAPQ of read from BAM file for supporting Indel (default: 15)"
    inputBinding:
      prefix: --mapq
  - id: length
    type:
      - 'null'
      - int
    doc: "Maximum deletion length to be detected (default: 1000000)"
    inputBinding:
      prefix: --length
outputs:
  - id: output_bam
    type: File
    doc: "Output BAM file with the indel information added"
    outputBinding:
      glob: $(inputs.output)
    secondaryFiles:
      - pattern: '.bai'
        required: false
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transindel:2.0--hdfd78af_0
