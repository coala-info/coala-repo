cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpstools depth
label: cpstools_depth
doc: "Calculate sequencing depth for paired-end reads against a reference genome.\n\
  \nTool homepage: https://github.com/Xwb7533/CPStools"
inputs:
  - id: block_size
    type:
      - 'null'
      - int
    doc: Block size
    inputBinding:
      position: 101
      prefix: --block_size
  - id: input_fasta
    type: File
    doc: Input/reference fasta file
    inputBinding:
      position: 101
      prefix: --input_fasta
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --output
  - id: p1
    type: File
    doc: Paired-End fastq file1
    inputBinding:
      position: 101
      prefix: --p1
  - id: p2
    type: File
    doc: Paired-End fastq file2
    inputBinding:
      position: 101
      prefix: --p2
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
stdout: cpstools_depth.out
