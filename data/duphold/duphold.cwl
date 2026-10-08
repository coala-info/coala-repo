cwlVersion: v1.2
class: CommandLineTool
baseCommand: duphold
label: duphold
doc: "duphold annotates structural variant calls with depth fold-change, read
  depth and SNP allele-balance information from a BAM/CRAM.\n\nTool homepage: https://github.com/brentp/duphold"
inputs:
  - id: bam
    type: File
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
      - pattern: ^.crai
        required: false
      - pattern: .csi
        required: false
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
    secondaryFiles:
      - .fai
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
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .tbi
        required: false
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
    doc: Standard output (annotated VCF when no output is given)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Annotated VCF/BCF written to the output path
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/duphold:0.2.1--hfb13731_0
stdout: duphold.out
