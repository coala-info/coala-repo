cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - somaticseq
label: somaticseq_paired
doc: "Run somatic variant callers in paired mode\n\nTool homepage: http://bioinform.github.io/somaticseq/"
inputs:
  - id: output_directory
    type:
      - 'null'
      - string
    doc: "output directory (default: .)"
    default: somaticseq_out
    inputBinding:
      position: 1
      prefix: --output-directory
  - id: genome_reference
    type: File
    doc: "FASTA reference (.fai index must sit beside it)"
    secondaryFiles:
      - pattern: '.fai'
        required: false
    inputBinding:
      position: 1
      prefix: --genome-reference
  - id: truth_snv
    type:
      - 'null'
      - File
    doc: "VCF of true hits"
    inputBinding:
      position: 1
      prefix: --truth-snv
  - id: truth_indel
    type:
      - 'null'
      - File
    doc: "VCF of true hits"
    inputBinding:
      position: 1
      prefix: --truth-indel
  - id: classifier_snv
    type:
      - 'null'
      - File
    doc: "snv classifier"
    inputBinding:
      position: 1
      prefix: --classifier-snv
  - id: classifier_indel
    type:
      - 'null'
      - File
    doc: "indel classifier"
    inputBinding:
      position: 1
      prefix: --classifier-indel
  - id: pass_threshold
    type:
      - 'null'
      - double
    doc: "SCORE for PASS (default: 0.5)"
    inputBinding:
      position: 1
      prefix: --pass-threshold
  - id: lowqual_threshold
    type:
      - 'null'
      - double
    doc: "SCORE for LowQual (default: 0.1)"
    inputBinding:
      position: 1
      prefix: --lowqual-threshold
  - id: algorithm
    type:
      - 'null'
      - string
    doc: "ada or xgboost (default: xgboost)"
    inputBinding:
      position: 1
      prefix: --algorithm
  - id: homozygous_threshold
    type:
      - 'null'
      - double
    doc: "VAF for homozygous (default: 0.85)"
    inputBinding:
      position: 1
      prefix: --homozygous-threshold
  - id: heterozygous_threshold
    type:
      - 'null'
      - double
    doc: "VAF for heterozygous (default: 0.01)"
    inputBinding:
      position: 1
      prefix: --heterozygous-threshold
  - id: minimum_mapping_quality
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality below which is considered poor (default: 1)"
    inputBinding:
      position: 1
      prefix: --minimum-mapping-quality
  - id: minimum_base_quality
    type:
      - 'null'
      - int
    doc: "Minimum base quality below which is considered poor (default: 5)"
    inputBinding:
      position: 1
      prefix: --minimum-base-quality
  - id: minimum_num_callers
    type:
      - 'null'
      - double
    doc: "Minimum number of tools to be considered (default: 0.5)"
    inputBinding:
      position: 1
      prefix: --minimum-num-callers
  - id: dbsnp_vcf
    type:
      - 'null'
      - File
    doc: "dbSNP VCF"
    secondaryFiles:
      - pattern: '.tbi'
        required: false
    inputBinding:
      position: 1
      prefix: --dbsnp-vcf
  - id: cosmic_vcf
    type:
      - 'null'
      - File
    doc: "COSMIC VCF"
    inputBinding:
      position: 1
      prefix: --cosmic-vcf
  - id: inclusion_region
    type:
      - 'null'
      - File
    doc: "inclusion bed"
    inputBinding:
      position: 1
      prefix: --inclusion-region
  - id: exclusion_region
    type:
      - 'null'
      - File
    doc: "exclusion bed"
    inputBinding:
      position: 1
      prefix: --exclusion-region
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads (default: 1)"
    inputBinding:
      position: 1
      prefix: --threads
  - id: somaticseq_train
    type:
      - 'null'
      - boolean
    doc: "Invoke training mode with ground truths (default: False)"
    inputBinding:
      position: 1
      prefix: --somaticseq-train
  - id: seed
    type:
      - 'null'
      - int
    doc: "seed for xgboost training (default: 0)"
    inputBinding:
      position: 1
      prefix: --seed
  - id: tree_depth
    type:
      - 'null'
      - int
    doc: "max tree depth for xgboost training (default: 12)"
    inputBinding:
      position: 1
      prefix: --tree-depth
  - id: iterations
    type:
      - 'null'
      - int
    doc: "num boosting rounds for xgboost: default is 500 for training and 100 for predicting"
    inputBinding:
      position: 1
      prefix: --iterations
  - id: features_excluded
    type:
      - 'null'
      - type: array
        items: string
    doc: "features to exclude for model. Must be same for train/predict."
    inputBinding:
      position: 1
      prefix: --features-excluded
  - id: extra_hyperparameters
    type:
      - 'null'
      - type: array
        items: string
    doc: "extra xgboost training hyperparameters in format of PARAM_1:VALUE_1 PARAM_2:VALUE_2"
    inputBinding:
      position: 1
      prefix: --extra-hyperparameters
  - id: keep_intermediates
    type:
      - 'null'
      - boolean
    doc: "Keep intermediate files (default: False)"
    inputBinding:
      position: 1
      prefix: --keep-intermediates
  - id: tumor_bam_file
    type: File
    doc: "Tumor BAM File"
    secondaryFiles:
      - pattern: '.bai'
        required: false
      - pattern: '^.bai'
        required: false
    inputBinding:
      position: 101
      prefix: --tumor-bam-file
  - id: normal_bam_file
    type: File
    doc: "Normal BAM File"
    secondaryFiles:
      - pattern: '.bai'
        required: false
      - pattern: '^.bai'
        required: false
    inputBinding:
      position: 101
      prefix: --normal-bam-file
  - id: tumor_sample
    type:
      - 'null'
      - string
    doc: "Tumor Name"
    inputBinding:
      position: 101
      prefix: --tumor-sample
  - id: normal_sample
    type:
      - 'null'
      - string
    doc: "Normal Name"
    inputBinding:
      position: 101
      prefix: --normal-sample
  - id: mutect_vcf
    type:
      - 'null'
      - File
    doc: "MuTect VCF"
    inputBinding:
      position: 101
      prefix: --mutect-vcf
  - id: indelocator_vcf
    type:
      - 'null'
      - File
    doc: "Indelocator VCF"
    inputBinding:
      position: 101
      prefix: --indelocator-vcf
  - id: mutect2_vcf
    type:
      - 'null'
      - File
    doc: "MuTect2 VCF"
    inputBinding:
      position: 101
      prefix: --mutect2-vcf
  - id: varscan_snv
    type:
      - 'null'
      - File
    doc: "VarScan2 VCF"
    inputBinding:
      position: 101
      prefix: --varscan-snv
  - id: varscan_indel
    type:
      - 'null'
      - File
    doc: "VarScan2 VCF"
    inputBinding:
      position: 101
      prefix: --varscan-indel
  - id: jsm_vcf
    type:
      - 'null'
      - File
    doc: "JointSNVMix2 VCF"
    inputBinding:
      position: 101
      prefix: --jsm-vcf
  - id: somaticsniper_vcf
    type:
      - 'null'
      - File
    doc: "SomaticSniper VCF"
    inputBinding:
      position: 101
      prefix: --somaticsniper-vcf
  - id: vardict_vcf
    type:
      - 'null'
      - File
    doc: "VarDict VCF"
    inputBinding:
      position: 101
      prefix: --vardict-vcf
  - id: muse_vcf
    type:
      - 'null'
      - File
    doc: "MuSE VCF"
    inputBinding:
      position: 101
      prefix: --muse-vcf
  - id: lofreq_snv
    type:
      - 'null'
      - File
    doc: "LoFreq VCF"
    inputBinding:
      position: 101
      prefix: --lofreq-snv
  - id: lofreq_indel
    type:
      - 'null'
      - File
    doc: "LoFreq VCF"
    inputBinding:
      position: 101
      prefix: --lofreq-indel
  - id: scalpel_vcf
    type:
      - 'null'
      - File
    doc: "Scalpel VCF"
    inputBinding:
      position: 101
      prefix: --scalpel-vcf
  - id: strelka_snv
    type:
      - 'null'
      - File
    doc: "Strelka VCF"
    inputBinding:
      position: 101
      prefix: --strelka-snv
  - id: strelka_indel
    type:
      - 'null'
      - File
    doc: "Strelka VCF"
    inputBinding:
      position: 101
      prefix: --strelka-indel
  - id: tnscope_vcf
    type:
      - 'null'
      - File
    doc: "TNscope VCF"
    inputBinding:
      position: 101
      prefix: --tnscope-vcf
  - id: platypus_vcf
    type:
      - 'null'
      - File
    doc: "Platypus VCF"
    inputBinding:
      position: 101
      prefix: --platypus-vcf
  - id: arbitrary_snvs
    type:
      - 'null'
      - type: array
        items: File
    doc: "Additional SNV VCFs"
    inputBinding:
      position: 101
      prefix: --arbitrary-snvs
  - id: arbitrary_indels
    type:
      - 'null'
      - type: array
        items: File
    doc: "Additional INDEL VCFs"
    inputBinding:
      position: 101
      prefix: --arbitrary-indels
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the consensus and classified VCF files
    outputBinding:
      glob: $(inputs.output_directory)
  - id: stdout
    type: stdout
    doc: Standard output
arguments:
  - position: 50
    valueFrom: paired
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/somaticseq:3.11.1--pyhdfd78af_0
stdout: somaticseq_paired.out
