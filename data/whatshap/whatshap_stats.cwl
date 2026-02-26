cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - whatshap
  - stats
label: whatshap_stats
doc: "Print phasing statistics of a single VCF file\n\nTool homepage: https://whatshap.readthedocs.io"
inputs:
  - id: vcf
    type: File
    doc: Phased VCF file
    inputBinding:
      position: 1
  - id: block_list
    type:
      - 'null'
      - File
    doc: Write list of all blocks to FILE (one block per line). 
      Nested/interleaved blocks are not split.
    inputBinding:
      position: 102
      prefix: --block-list
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
  - id: chromosome
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of chromosome(s) to process. If not given, all chromosomes in the 
      input VCF are considered. Can be used multiple times and accepts a 
      comma-separated list.
    inputBinding:
      position: 102
      prefix: --chromosome
  - id: gtf
    type:
      - 'null'
      - File
    doc: Write phased blocks as GTF with each block represented as a 'gene'. If 
      blocks are interleaved or nested, they are split into multiple 'exons'.
    inputBinding:
      position: 102
      prefix: --gtf
  - id: only_snvs
    type:
      - 'null'
      - boolean
    doc: Only process SNVs and ignore all other variants.
    inputBinding:
      position: 102
      prefix: --only-snvs
  - id: sample
    type:
      - 'null'
      - string
    doc: Name of the sample to process. If not given, use first sample found in 
      VCF.
    inputBinding:
      position: 102
      prefix: --sample
outputs:
  - id: tsv
    type:
      - 'null'
      - File
    doc: Write statistics in tab-separated value format to FILE
    outputBinding:
      glob: $(inputs.tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
