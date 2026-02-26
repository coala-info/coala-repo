cwlVersion: v1.2
class: CommandLineTool
baseCommand: vafator
label: vafator
doc: "vafator v2.2.2\n\nTool homepage: https://github.com/tron-bioinformatics/vafator"
inputs:
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: A sample name and a BAM file. Can be used multiple times to input 
      multiple samples and multiple BAM files. The same sample name can be used 
      multiple times with different BAMs, this will treated as replicates.
    inputBinding:
      position: 101
      prefix: --bam
  - id: base_call_quality
    type:
      - 'null'
      - int
    doc: All bases with a base call quality below this threshold will be 
      filtered out
    default: 30
    inputBinding:
      position: 101
      prefix: --base-call-quality
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Error rate to use in the power calculation
    default: 0.001
    inputBinding:
      position: 101
      prefix: --error-rate
  - id: fpr
    type:
      - 'null'
      - float
    doc: False Positive Rate (FPR) to use in the power calculation
    default: '5e-07'
    inputBinding:
      position: 101
      prefix: --fpr
  - id: include_ambiguous_bases
    type:
      - 'null'
      - boolean
    doc: Flag indicating to include ambiguous bases from the DP calculation
    default: false
    inputBinding:
      position: 101
      prefix: --include-ambiguous-bases
  - id: input_vcf
    type: File
    doc: The VCF to annotate
    inputBinding:
      position: 101
      prefix: --input-vcf
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: All reads with a mapping quality below this threshold will be filtered 
      out
    default: 1
    inputBinding:
      position: 101
      prefix: --mapping-quality
  - id: normal_ploidy
    type:
      - 'null'
      - int
    doc: Normal ploidy for the power calculation
    default: 2
    inputBinding:
      position: 101
      prefix: --normal-ploidy
  - id: purity
    type:
      - 'null'
      - type: array
        items: float
    doc: A sample name and a tumor purity value. Can be used multiple times to 
      input multiple samples in combination with --bam. If no purity is provided
      for a given sample the default value is 1.0
    inputBinding:
      position: 101
      prefix: --purity
  - id: tumor_ploidy
    type:
      - 'null'
      - type: array
        items: string
    doc: 'A sample name and a tumor ploidy. Can be used multiple times to input multiple
      samples in combination with --bam. The tumor ploidy can be provided as a genome-wide
      value (eg: --tumor-ploidy primary 2) or as local copy numbers in a BED file
      (eg: --tumor-ploidy primary /path/to/copy_numbers.bed), see the documentation
      for expected BED format'
    inputBinding:
      position: 101
      prefix: --tumor-ploidy
outputs:
  - id: output_vcf
    type: File
    doc: The annotated VCF
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vafator:2.2.2--pyhdfd78af_0
