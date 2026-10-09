cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - liqa
label: liqa_quantify
doc: "Quantify isoform expression from aligned long-read RNA-seq data (BAM) and a refgene file.\n\nTool homepage: https://github.com/WGLab/LIQA"
arguments:
  - position: 0
    prefix: -task
    valueFrom: quantify
inputs:
  - id: refgene
    type: File
    doc: Reference file obtained with liqa refgene.
    inputBinding:
      position: 1
      prefix: -refgene
  - id: bam
    type: File
    secondaryFiles:
      - .bai
    doc: Aligned long-read RNA-seq BAM file (sorted, with .bai index).
    inputBinding:
      position: 2
      prefix: -bam
  - id: out
    type: string
    doc: Output file for the isoform expression estimates.
    inputBinding:
      position: 3
      prefix: -out
  - id: max_distance
    type:
      - 'null'
      - int
    doc: Maximum length of an alignment error at an exon boundary. Recommended 20.
    inputBinding:
      position: 4
      prefix: -max_distance
  - id: f_weight
    type:
      - 'null'
      - float
    doc: Weight for bias correction in isoform usage estimation. Recommended 1.
    inputBinding:
      position: 5
      prefix: -f_weight
outputs:
  - id: isoform_estimates
    type: File
    doc: Isoform expression estimates.
    outputBinding:
      glob: $(inputs.out)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/liqa:1.3.4--pyhdfd78af_0
stdout: liqa_quantify.out
