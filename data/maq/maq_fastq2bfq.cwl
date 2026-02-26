cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - fastq2bfq
label: maq_fastq2bfq
doc: "Convert FASTQ to bfq format\n\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
  - id: output_prefix_or_bfq
    type: string
    doc: Output prefix or BFQ file
    inputBinding:
      position: 2
  - id: nreads
    type:
      - 'null'
      - int
    doc: number of reads to convert
    inputBinding:
      position: 103
      prefix: -n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_fastq2bfq.out
