cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gemini
  - set_somatic
label: gemini_set_somatic
doc: "Set the is_somatic flag for variants in a gemini database.\n\nTool homepage:
  https://github.com/arq5x/gemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be updated.
    inputBinding:
      position: 1
  - id: chrom
    type:
      - 'null'
      - string
    doc: A specific chromosome on which to tag somatic mutations.
    default: None
    inputBinding:
      position: 102
      prefix: --chrom
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Don't set the is_somatic flag, just report what _would_ be set. For 
      testing parameters.
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: max_norm_alt_count
    type:
      - 'null'
      - int
    doc: The max count. of the alt. allele in the normal sample
    default: 0
    inputBinding:
      position: 102
      prefix: --max-norm-alt-count
  - id: max_norm_alt_freq
    type:
      - 'null'
      - float
    doc: The max freq. of the alt. allele in the normal sample
    default: 0.0
    inputBinding:
      position: 102
      prefix: --max-norm-alt-freq
  - id: min_depth
    type:
      - 'null'
      - int
    doc: The min combined depth for tumor + normal
    default: 0
    inputBinding:
      position: 102
      prefix: --min-depth
  - id: min_norm_depth
    type:
      - 'null'
      - int
    doc: The minimum depth allowed in the normal sample to believe somatic
    default: 0
    inputBinding:
      position: 102
      prefix: --min-norm-depth
  - id: min_qual
    type:
      - 'null'
      - int
    doc: The min variant quality (VCF QUAL)
    default: 0
    inputBinding:
      position: 102
      prefix: --min-qual
  - id: min_somatic_score
    type:
      - 'null'
      - int
    doc: The min somatic score (SSC)
    default: 0
    inputBinding:
      position: 102
      prefix: --min-somatic-score
  - id: min_tumor_alt_count
    type:
      - 'null'
      - int
    doc: The min count. of the alt. allele in the tumor sample
    default: 0
    inputBinding:
      position: 102
      prefix: --min-tumor-alt-count
  - id: min_tumor_alt_freq
    type:
      - 'null'
      - float
    doc: The min freq. of the alt. allele in the tumor sample
    default: 0.0
    inputBinding:
      position: 102
      prefix: --min-tumor-alt-freq
  - id: min_tumor_depth
    type:
      - 'null'
      - int
    doc: The minimum depth allowed in the tumor sample to believe somatic
    default: 0
    inputBinding:
      position: 102
      prefix: --min-tumor-depth
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_set_somatic.out
