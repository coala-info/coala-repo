cwlVersion: v1.2
class: CommandLineTool
baseCommand: duphold
label: duphold
doc: "duphold is a tool for calling structural variants (SVs) from long-read sequencing
  data.\n\nTool homepage: https://github.com/brentp/duphold"
inputs:
  - id: bam
    type: File
    doc: path to indexed BAM/CRAM
    inputBinding:
      position: 101
      prefix: --bam
  - id: drop
    type:
      - 'null'
      - boolean
    doc: drop all samples from a multi-sample --vcf *except* the sample in 
      --bam. useful for parallelization by sample followed by merge.
    inputBinding:
      position: 101
      prefix: --drop
  - id: fasta
    type: File
    doc: indexed fasta reference.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: output
    type:
      - 'null'
      - string
    doc: output VCF/BCF (default is VCF to stdout)
    inputBinding:
      position: 101
      prefix: --output
  - id: snp
    type:
      - 'null'
      - File
    doc: optional path to snp/indel VCF/BCF with which to annotate SVs. BCF is 
      highly recommended as it's much faster to parse.
    inputBinding:
      position: 101
      prefix: --snp
  - id: threads
    type:
      - 'null'
      - int
    doc: number of decompression threads.
    inputBinding:
      position: 101
      prefix: --threads
  - id: vcf
    type: File
    doc: path to sorted SV VCF/BCF
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/duphold:0.2.1--hfb13731_0
stdout: duphold.out
