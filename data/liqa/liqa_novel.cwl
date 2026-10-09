cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - liqa
label: liqa_novel
doc: "Detect novel isoforms from aligned long-read RNA-seq data (BAM) and a refgene file.\n\nTool homepage: https://github.com/WGLab/LIQA"
arguments:
  - position: 0
    prefix: -task
    valueFrom: novel
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
    doc: Output file for the novel isoform results.
    inputBinding:
      position: 3
      prefix: -out
  - id: num_cover
    type:
      - 'null'
      - int
    doc: Number of bp coverage needed.
    inputBinding:
      position: 4
      prefix: -num_cover
  - id: num_support_read
    type:
      - 'null'
      - int
    doc: Number of supporting reads needed.
    inputBinding:
      position: 5
      prefix: -num_support_read
outputs:
  - id: novel_isoforms
    type: File
    doc: Reference file extended with the novel isoforms.
    outputBinding:
      glob: $(inputs.out)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/liqa:1.3.4--pyhdfd78af_0
stdout: liqa_novel.out
