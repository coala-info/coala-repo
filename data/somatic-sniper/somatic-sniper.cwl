cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam-somaticsniper
label: somatic-sniper
doc: "SomaticSniper identifies single nucleotide variants (SNVs) that are different
  between tumor and normal BAM files.\n\nTool homepage: https://github.com/genome/somatic-sniper"
inputs:
  - id: tumor_bam
    type: File
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    doc: 'Tumor BAM file'
    inputBinding:
      position: 1
  - id: normal_bam
    type: File
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    doc: 'Normal BAM file'
    inputBinding:
      position: 2
  - id: output_file_path
    type: string
    doc: 'Somatic SNV output file'
    inputBinding:
      position: 3
  - id: reference_fasta
    type: File
    secondaryFiles:
      - .fai
    doc: 'REQUIRED reference sequence in the FASTA format'
    inputBinding:
      position: 103
      prefix: -f
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: 'filtering reads with mapping quality less than INT [0]'
    inputBinding:
      position: 103
      prefix: -q
  - id: min_somatic_score
    type:
      - 'null'
      - int
    doc: 'filtering somatic snv output with somatic quality less than INT [15]'
    inputBinding:
      position: 103
      prefix: -Q
  - id: no_loh
    type:
      - 'null'
      - boolean
    doc: 'do not report LOH variants as determined by genotypes'
    inputBinding:
      position: 103
      prefix: -L
  - id: no_gain_of_reference
    type:
      - 'null'
      - boolean
    doc: 'do not report Gain of Reference variants as determined by genotypes'
    inputBinding:
      position: 103
      prefix: -G
  - id: disable_priors
    type:
      - 'null'
      - boolean
    doc: 'disable priors in the somatic calculation. Increases sensitivity for solid tumors'
    inputBinding:
      position: 103
      prefix: -p
  - id: use_somatic_mutation_rate_priors
    type:
      - 'null'
      - boolean
    doc: 'Use prior probabilities accounting for the somatic mutation rate'
    inputBinding:
      position: 103
      prefix: -J
  - id: prior_probability
    type:
      - 'null'
      - float
    doc: 'prior probability of a somatic mutation (implies -J) [0.010000]'
    inputBinding:
      position: 103
      prefix: -s
  - id: theta
    type:
      - 'null'
      - float
    doc: 'theta in maq consensus calling model (for -c/-g) [0.850000]'
    inputBinding:
      position: 103
      prefix: -T
  - id: num_haplotypes
    type:
      - 'null'
      - int
    doc: 'number of haplotypes in the sample (for -c/-g) [2]'
    inputBinding:
      position: 103
      prefix: -N
  - id: haplotype_difference_prior
    type:
      - 'null'
      - float
    doc: 'prior of a difference between two haplotypes (for -c/-g) [0.001000]'
    inputBinding:
      position: 103
      prefix: -r
  - id: normal_sample_id
    type:
      - 'null'
      - string
    doc: 'normal sample id (for VCF header) [NORMAL]'
    inputBinding:
      position: 103
      prefix: -n
  - id: tumor_sample_id
    type:
      - 'null'
      - string
    doc: 'tumor sample id (for VCF header) [TUMOR]'
    inputBinding:
      position: 103
      prefix: -t
  - id: out_format
    type:
      - 'null'
      - string
    doc: 'select output format [classic]; available formats: classic, vcf, bed'
    inputBinding:
      position: 103
      prefix: -F
outputs:
  - id: output_file
    type: File
    doc: Output file for somatic SNVs
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/somatic-sniper:1.0.5.0--0
