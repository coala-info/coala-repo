cwlVersion: v1.2
class: CommandLineTool
baseCommand: SampleSimilarity
label: ngs-bits_SampleSimilarity
doc: "Calculates pairwise sample similarity metrics from VCF/BAM/CRAM files.\n\nTool
  homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: build
    type:
      - 'null'
      - string
    doc: "Genome build used to generate the input (BAM mode).\n                  \
      \    Valid: 'hg19,hg38'"
    default: hg38
    inputBinding:
      position: 101
      prefix: -build
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debug output.
    default: 'false'
    inputBinding:
      position: 101
      prefix: -debug
  - id: include_gonosomes
    type:
      - 'null'
      - boolean
    doc: Includes gonosomes into calculation (by default only variants on 
      autosomes are considered).
    default: 'false'
    inputBinding:
      position: 101
      prefix: -include_gonosomes
  - id: input_filelist
    type:
      type: array
      items: File
    doc: Input variant lists in VCF format (two or more). If only one file is 
      given, each line in this file is interpreted as an input file path.
    inputBinding:
      position: 101
      prefix: -in
  - id: long_read
    type:
      - 'null'
      - boolean
    doc: Support long reads (BAM mode).
    default: 'false'
    inputBinding:
      position: 101
      prefix: -long_read
  - id: max_snps
    type:
      - 'null'
      - int
    doc: The maximum number of high-coverage SNPs to extract from BAM/CRAM. 0 
      means unlimited (BAM mode).
    default: 5000
    inputBinding:
      position: 101
      prefix: -max_snps
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum coverage to consider a SNP for the analysis (BAM mode).
    default: 30
    inputBinding:
      position: 101
      prefix: -min_cov
  - id: mode
    type:
      - 'null'
      - string
    doc: "Mode (input format).\n                      Valid: 'vcf,gsvar,bam'"
    default: vcf
    inputBinding:
      position: 101
      prefix: -mode
  - id: ref
    type:
      - 'null'
      - File
    doc: Reference genome for CRAM support (mandatory if CRAM is used).
    default: ''
    inputBinding:
      position: 101
      prefix: -ref
  - id: roi
    type:
      - 'null'
      - File
    doc: Restrict similarity calculation to variants in target region.
    default: ''
    inputBinding:
      position: 101
      prefix: -roi
  - id: roi_hg38_wes_wgs
    type:
      - 'null'
      - boolean
    doc: Used pre-defined high-confidence coding region of hg38. Speeds up 
      calculations, especially for WGS. Also makes scores comparable when mixing
      WES and WGS or different WES kits.
    default: 'false'
    inputBinding:
      position: 101
      prefix: -roi_hg38_wes_wgs
  - id: settings
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file. If unset, writes to STDOUT.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
