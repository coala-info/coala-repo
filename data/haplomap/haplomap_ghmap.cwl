cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haplomap
  - ghmap
label: haplomap_ghmap
doc: "Haplotype association test (ANOVA)\n\nTool homepage: https://github.com/zqfang/haplomap"
inputs:
  - id: blocks
    type: File
    doc: "Haploblocks file, the output file from (eblocks -o)"
    inputBinding:
      position: 1
      prefix: --blocks
  - id: categorical
    type:
      - 'null'
      - boolean
    doc: "phenotype (-p) is categorical"
    inputBinding:
      position: 1
      prefix: --categorical
  - id: expression
    type:
      - 'null'
      - File
    doc: "Gene expression file"
    inputBinding:
      position: 1
      prefix: --expression
  - id: filter_coding
    type:
      - 'null'
      - boolean
    doc: "Filter out non-coding blocks"
    inputBinding:
      position: 1
      prefix: --filter_coding
  - id: gene
    type:
      - 'null'
      - string
    doc: "Gene name (the code reads an argument for -g; gene-summaried output is the default and needs no flag)"
    inputBinding:
      position: 1
      prefix: --gene
  - id: gene_all_blocks
    type:
      - 'null'
      - boolean
    doc: "Output gene-oriented results of all blocks that overalp a gene."
    inputBinding:
      position: 1
      prefix: --gene_all_blocks
  - id: gene_block
    type:
      - 'null'
      - boolean
    doc: "Output gene-oriented results block by block. almost the same to -a"
    inputBinding:
      position: 1
      prefix: --gene_block
  - id: haploblocks
    type:
      - 'null'
      - boolean
    doc: "Output block-oriented results."
    inputBinding:
      position: 1
      prefix: --haploblocks
  - id: name
    type:
      - 'null'
      - string
    doc: "Name of phenotype dataset; add suffix _SNP|_INDEL|_SV (e.g. MPD123_SNP) to select the correct CodonFlag in the output"
    inputBinding:
      position: 1
      prefix: --name
  - id: phenotypes
    type: File
    doc: "Phenotype file, the same input file of (eblocks -s)"
    inputBinding:
      position: 1
      prefix: --phenotypes
  - id: pvalue_cutoff
    type:
      - 'null'
      - float
    doc: "Only write results with pvalue < cutoff. Default: 0.05"
    inputBinding:
      position: 1
      prefix: -l
  - id: relation
    type:
      - 'null'
      - File
    doc: "Genetic relation file (.rel) for population structure analysis; n x n matrix with a header line (starts with #) containing sample names"
    inputBinding:
      position: 1
      prefix: --relation
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose"
    inputBinding:
      position: 1
      prefix: --verbose
  - id: output_path
    type: string
    doc: "Output file name"
    inputBinding:
      position: 1
      prefix: --output
outputs:
  - id: output
    type: File
    doc: "Association test results"
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplomap:0.1.2--h4656aac_1
