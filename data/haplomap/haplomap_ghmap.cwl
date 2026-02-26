cwlVersion: v1.2
class: CommandLineTool
baseCommand: ghmap
label: haplomap_ghmap
doc: "Output gene-summaried results by default.\n\nTool homepage: https://github.com/zqfang/haplomap"
inputs:
  - id: blocks
    type: File
    doc: The output file from (eblocks -o)
    inputBinding:
      position: 101
      prefix: --blocks
  - id: categorical
    type:
      - 'null'
      - boolean
    doc: phenotype (-p) is categorical
    inputBinding:
      position: 101
      prefix: --categorical
  - id: expression
    type:
      - 'null'
      - File
    doc: name of file
    inputBinding:
      position: 101
      prefix: --expression
  - id: filter_coding
    type:
      - 'null'
      - boolean
    doc: Filter out non-coding blocks
    inputBinding:
      position: 101
      prefix: --filter_coding
  - id: gene
    type:
      - 'null'
      - boolean
    doc: "Output gene-summaried results. Default.\nNOTE:: Only write the overlapped
      halpoblock with best pvalue/Fstat, representing all overlapped blocks. \n  \
      \    The CodonFlag is an aggregated indicator showing that a gene has blocks
      with coding change. \n      The best block itself might not contain any coding
      changes. \n      Run the ghmap with -a/k/m tag will give you all overlapped
      blocks with correct CodonFlag."
    inputBinding:
      position: 101
      prefix: --gene
  - id: gene_all_blocks
    type:
      - 'null'
      - boolean
    doc: Output gene-oriented results of all blocks that overalp a gene.
    inputBinding:
      position: 101
      prefix: --gene_all_blocks
  - id: gene_block
    type:
      - 'null'
      - boolean
    doc: Output gene-oriented results block by block. almost the same to -a
    inputBinding:
      position: 101
      prefix: --gene_block
  - id: haploblocks
    type:
      - 'null'
      - boolean
    doc: Output block-oriented results.
    inputBinding:
      position: 101
      prefix: --haploblocks
  - id: name
    type:
      - 'null'
      - string
    doc: 'NOTE:: Add suffix `_SNP`|`_INDEL`|`_SV`(e.g. MPD123_SNP) can help select
      correct CodonFlag in the output.'
    inputBinding:
      position: 101
      prefix: --name
  - id: phenotypes
    type: File
    doc: The same input file of (eblocks -b)
    inputBinding:
      position: 101
      prefix: --phenotypes
  - id: pvalue_cutoff
    type:
      - 'null'
      - float
    doc: 'Only write results with pvalue < cutoff. Default: 0.05'
    default: 0.05
    inputBinding:
      position: 101
      prefix: --pvalue_cutoff
  - id: relation
    type:
      - 'null'
      - File
    doc: "<.rel> file for population structure analysis.\nn x n matrix with header
      line (startswith '#') contain sample names."
    inputBinding:
      position: 101
      prefix: --relation
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: Output gene-summaried results by default.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplomap:0.1.2--h4656aac_1
