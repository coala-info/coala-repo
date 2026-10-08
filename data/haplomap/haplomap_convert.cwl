cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haplomap
  - convert
label: haplomap_convert
doc: "Convert VCF to NIEHS compact format\n\nTool homepage: https://github.com/zqfang/haplomap"
inputs:
  - id: max_strand_bias
    type:
      - 'null'
      - int
    doc: "Max Phred-scaled pvalue for strand bias (the lower, the better). Default 50."
    inputBinding:
      position: 1
      prefix: --strand-bias
  - id: min_allelic_depth
    type:
      - 'null'
      - int
    doc: "Min allelic depth (AD) of samples. Default 3."
    inputBinding:
      position: 1
      prefix: --allelic-depth
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: "Min average mapping quality. Default 20."
    inputBinding:
      position: 1
      prefix: --mapping-quality
  - id: min_qual
    type:
      - 'null'
      - int
    doc: "QUAL field of VCF file. Only keep variant > qual. Default 50."
    inputBinding:
      position: 1
      prefix: --qual
  - id: min_ratio
    type:
      - 'null'
      - float
    doc: "Min ratio of (%MAX(AD) / %MAX(DP)). Default 0.1."
    inputBinding:
      position: 1
      prefix: --ratio
  - id: output_plink
    type:
      - 'null'
      - boolean
    doc: "Output tped, tfam file for plink. Default: false."
    inputBinding:
      position: 1
      prefix: --plink
  - id: pl_diff
    type:
      - 'null'
      - int
    doc: "Phred-scaled genotype likelihood (PL) difference. Default 20."
    inputBinding:
      position: 1
      prefix: --pl-diff
  - id: samples_file
    type:
      - 'null'
      - File
    doc: "New sample order file. One name per line."
    inputBinding:
      position: 1
      prefix: --samples
  - id: variant_type
    type:
      - 'null'
      - string
    doc: "Select variant type: [snp|indel|sv]. Default: snp"
    inputBinding:
      position: 1
      prefix: --type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose"
    inputBinding:
      position: 1
      prefix: --verbose
  - id: output_file_path
    type: string
    doc: "Output file name"
    inputBinding:
      position: 1
      prefix: --output
  - id: input_vcf
    type: File
    doc: "Input sorted VCF file or stdin"
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type: File
    doc: "Compact variant table"
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: tped
    type:
      - 'null'
      - File
    doc: "PLINK tped file, written with --plink"
    outputBinding:
      glob: '*.tped'
  - id: tfam
    type:
      - 'null'
      - File
    doc: "PLINK tfam file, written with --plink"
    outputBinding:
      glob: '*.tfam'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplomap:0.1.2--h4656aac_1
