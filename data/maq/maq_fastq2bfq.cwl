cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - fastq2bfq
label: maq_fastq2bfq
doc: "Convert FASTQ to bfq format\n\nTool homepage: http://maq.sourceforge.net/"
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
    doc: number of reads per output file (the output is split into <prefix>@<first read>.bfq files)
    inputBinding:
      position: 103
      prefix: -n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_prefix_or_bfq_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output_prefix_or_bfq
    outputBinding:
      glob: $(inputs.output_prefix_or_bfq)*
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_fastq2bfq.out
