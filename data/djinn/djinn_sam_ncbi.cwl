cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - djinn
  - sam
  - ncbi
label: djinn_sam_ncbi
doc: "BAM → FASTQ conversion from NCBI\n\nTool homepage: https://github.com/pdimens/djinn"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (minimum 2)
    inputBinding:
      position: 1
      prefix: --threads
  - id: prefix
    type: string
    doc: Output file name prefix
    inputBinding:
      position: 101
  - id: input
    type: File
    doc: Input SAM/BAM file
    inputBinding:
      position: 102
outputs:
  - id: r1_fastq
    type: File
    doc: Output R1 FASTQ (<prefix>.R1.fq.gz)
    outputBinding:
      glob: $(inputs.prefix).R1.fq.gz
  - id: r2_fastq
    type: File?
    doc: Output R2 FASTQ (<prefix>.R2.fq.gz)
    outputBinding:
      glob: $(inputs.prefix).R2.fq.gz
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
