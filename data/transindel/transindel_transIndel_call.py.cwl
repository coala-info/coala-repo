cwlVersion: v1.2
class: CommandLineTool
baseCommand: transIndel_call.py
label: transindel_transIndel_call.py
doc: "Call mid-sized insertions and large deletions from the BAM file made by transIndel_build_DNA.py or transIndel_build_RNA.py and write a VCF file.\n\nTool homepage: https://github.com/cauyrd/transIndel"
inputs:
  - id: input
    type: File
    secondaryFiles:
      - pattern: '.bai'
        required: true
    doc: "Input BAM file (from transIndel_build)"
    inputBinding:
      prefix: --input
  - id: output
    type: string
    doc: "output VCF file prefix (the VCF is named PREFIX.indel.vcf)"
    inputBinding:
      prefix: --output
  - id: ao
    type:
      - 'null'
      - int
    doc: "minimal observation count for Indel (default: 4)"
    inputBinding:
      prefix: --ao
  - id: depth
    type:
      - 'null'
      - int
    doc: "minimal depth to call Indel (default: 10)"
    inputBinding:
      prefix: --depth
  - id: vaf
    type:
      - 'null'
      - float
    doc: "minimal variant allele frequency (default: 0.1)"
    inputBinding:
      prefix: --vaf
  - id: length
    type:
      - 'null'
      - int
    doc: "minimal Indel length (>=1) to report (default: 10)"
    inputBinding:
      prefix: --length
  - id: mapq
    type:
      - 'null'
      - int
    doc: "minimal MAPQ of read from BAM file to call Indel (default: 15)"
    inputBinding:
      prefix: -m
  - id: region
    type:
      - 'null'
      - string
    doc: "Limit analysis to targets listed in the BED-format FILE or a samtools region string"
    inputBinding:
      prefix: -t
outputs:
  - id: indel_vcf
    type: File
    doc: "VCF file with the called indels"
    outputBinding:
      glob: $(inputs.output).indel.vcf
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transindel:2.0--hdfd78af_0
