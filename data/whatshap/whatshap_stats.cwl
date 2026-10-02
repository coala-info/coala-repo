cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - whatshap
  - stats
label: whatshap_stats
doc: Print phasing statistics of a single VCF file
inputs:
  - id: vcf
    type: File
    doc: Phased VCF file
    inputBinding:
      position: 1
  - id: gtf
    type:
      - 'null'
      - string
    doc: Write phased blocks as GTF with each block represented as a 'gene'. If 
      blocks are interleaved or nested, they are split into multiple 'exons'.
    inputBinding:
      position: 102
      prefix: --gtf
  - id: block_list
    type:
      - 'null'
      - string
    doc: Write list of all blocks to FILE (one block per line). 
      Nested/interleaved blocks are not split.
    inputBinding:
      position: 102
      prefix: --block-list
  - id: sample
    type:
      - 'null'
      - string
    doc: Name of the sample to process. If not given, use first sample found in 
      VCF.
    inputBinding:
      position: 102
      prefix: --sample
  - id: chr_lengths
    type:
      - 'null'
      - File
    doc: Override chromosome lengths in VCF with those from FILE (one line per 
      chromosome, tab separated '<chr> <length>'). Lengths are used to compute 
      NG50 values.
    inputBinding:
      position: 102
      prefix: --chr-lengths
  - id: tsv
    type:
      - 'null'
      - string
    doc: Write statistics in tab-separated value format to FILE
    inputBinding:
      position: 102
      prefix: --tsv
  - id: only_snvs
    type:
      - 'null'
      - boolean
    doc: Only process SNVs and ignore all other variants.
    inputBinding:
      position: 102
      prefix: --only-snvs
  - id: chromosome
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --chromosome
          separate: true
    doc: Name of chromosome(s) to process. If not given, all chromosomes in the 
      input VCF are considered. Can be used multiple times and accepts a 
      comma-separated list.
    inputBinding:
      position: 102
outputs:
  - id: output_gtf
    type:
      - 'null'
      - File
    doc: Write phased blocks as GTF with each block represented as a 'gene'. If 
      blocks are interleaved or nested, they are split into multiple 'exons'.
    outputBinding:
      glob: $(inputs.gtf)
  - id: output_block_list
    type:
      - 'null'
      - File
    doc: Write list of all blocks to FILE (one block per line). 
      Nested/interleaved blocks are not split.
    outputBinding:
      glob: $(inputs.block_list)
  - id: output_tsv
    type:
      - 'null'
      - File
    doc: Write statistics in tab-separated value format to FILE
    outputBinding:
      glob: $(inputs.tsv)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
s:url: https://whatshap.readthedocs.io
$namespaces:
  s: https://schema.org/
