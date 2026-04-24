cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - whatshap
  - compare
label: whatshap_compare
doc: "Compare two or more phased variant files\n\nTool homepage: https://whatshap.readthedocs.io"
inputs:
  - id: vcf_bcf_files
    type:
      type: array
      items: File
    doc: At least two phased variant files (VCF or BCF) to be compared.
    inputBinding:
      position: 1
  - id: ignore_sample_name
    type:
      - 'null'
      - boolean
    doc: For single sample VCFs, ignore sample name and assume all samples are 
      the same.
    inputBinding:
      position: 102
      prefix: --ignore-sample-name
  - id: names
    type:
      - 'null'
      - string
    doc: Comma-separated list of data set names to be used in the report (in 
      same order as VCFs).
    inputBinding:
      position: 102
      prefix: --names
  - id: only_snvs
    type:
      - 'null'
      - boolean
    doc: Only process SNVs and ignore all other variants.
    inputBinding:
      position: 102
      prefix: --only-snvs
  - id: ploidy
    type:
      - 'null'
      - int
    doc: 'The ploidy of the sample(s) (default: 2).'
    inputBinding:
      position: 102
      prefix: --ploidy
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
  - id: tsv_pairwise
    type:
      - 'null'
      - File
    doc: Filename to write comparison results from pair-wise comparison to 
      (tab-separated).
    outputBinding:
      glob: $(inputs.tsv_pairwise)
  - id: tsv_multiway
    type:
      - 'null'
      - File
    doc: Filename to write comparison results from multiway comparison to 
      (tab-separated). Only for diploid VCFs.
    outputBinding:
      glob: $(inputs.tsv_multiway)
  - id: switch_error_bed
    type:
      - 'null'
      - File
    doc: Write BED file with switch error positions to given filename. Only for 
      diploid VCFs.
    outputBinding:
      glob: $(inputs.switch_error_bed)
  - id: plot_blocksizes
    type:
      - 'null'
      - File
    doc: Write PDF file with a block length histogram to given filename 
      (requires matplotlib).
    outputBinding:
      glob: $(inputs.plot_blocksizes)
  - id: plot_sum_of_blocksizes
    type:
      - 'null'
      - File
    doc: Write PDF file with a block length histogram in which the height of 
      each bar corresponds to the sum of lengths.
    outputBinding:
      glob: $(inputs.plot_sum_of_blocksizes)
  - id: longest_block_tsv
    type:
      - 'null'
      - File
    doc: Write position-wise agreement of longest joint blocks in each 
      chromosome to tab-separated file. Only for diploid VCFs.
    outputBinding:
      glob: $(inputs.longest_block_tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
