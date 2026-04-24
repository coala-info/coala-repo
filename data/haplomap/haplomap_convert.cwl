cwlVersion: v1.2
class: CommandLineTool
baseCommand: convert
label: haplomap_convert
doc: "Convert VCF to NIEHS compact format\n\nTool homepage: https://github.com/zqfang/haplomap"
inputs:
  - id: input_vcf
    type: File
    doc: Input sorted VCF file or stdin
    inputBinding:
      position: 1
  - id: max_strand_bias
    type:
      - 'null'
      - int
    doc: Max Phred-scaled pvalue for strand bias (the lower, the better).
    inputBinding:
      position: 102
      prefix: --strand-bias
  - id: min_allelic_depth
    type:
      - 'null'
      - int
    doc: Min allelic depth (AD) of samples.
    inputBinding:
      position: 102
      prefix: --allelic-depth
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Min average mapping quality.
    inputBinding:
      position: 102
      prefix: --mapping-quality
  - id: min_qual
    type:
      - 'null'
      - int
    doc: QUAL field of VCF file. Only keep variant > qual.
    inputBinding:
      position: 102
      prefix: --qual
  - id: min_ratio
    type:
      - 'null'
      - float
    doc: Min ratio of (%MAX(AD) / %MAX(DP)).
    inputBinding:
      position: 102
      prefix: --ratio
  - id: output_plink
    type:
      - 'null'
      - boolean
    doc: Output tped, tfam file for plink.
    inputBinding:
      position: 102
      prefix: --plink
  - id: pl_diff
    type:
      - 'null'
      - int
    doc: Phred-scaled genotype likelihood (PL) difference. GT's PL must at least
      pl-diff unit lower than any other PL value. The greater, the more '?' in 
      the output.
    inputBinding:
      position: 102
      prefix: --pl-diff
  - id: samples_file
    type:
      - 'null'
      - File
    doc: New sample order file. One name per line.
    inputBinding:
      position: 102
      prefix: --samples
  - id: variant_type
    type:
      - 'null'
      - string
    doc: 'Select variant type: [snp|indel|sv]'
    inputBinding:
      position: 102
      prefix: --type
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplomap:0.1.2--h4656aac_1
