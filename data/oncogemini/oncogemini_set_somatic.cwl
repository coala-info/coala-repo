cwlVersion: v1.2
class: CommandLineTool
baseCommand: oncogemini set_somatic
label: oncogemini_set_somatic
doc: "Set somatic status for variants in a database.\n\nTool homepage: https://github.com/fakedrtom/oncogemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be updated.
    inputBinding:
      position: 1
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Don't set the is_somatic flag, just report what _would_ be set. For 
      testing parameters.
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: min_dp
    type:
      - 'null'
      - int
    doc: Minimum depth required in all samples
    inputBinding:
      position: 102
      prefix: --minDP
  - id: min_gq
    type:
      - 'null'
      - int
    doc: Minimum genotype quality required in all samples
    inputBinding:
      position: 102
      prefix: --minGQ
  - id: norm_af
    type:
      - 'null'
      - float
    doc: The maximum frequency of the alternate allele in the normal sample
    inputBinding:
      position: 102
      prefix: --normAF
  - id: norm_count
    type:
      - 'null'
      - int
    doc: The maximum count of the alternate allele in the normal sample
    inputBinding:
      position: 102
      prefix: --normCount
  - id: norm_dp
    type:
      - 'null'
      - int
    doc: The minimum depth allowed in the normal sample to believe somatic
    inputBinding:
      position: 102
      prefix: --normDP
  - id: purity
    type:
      - 'null'
      - boolean
    doc: Using purity estimates in sample manifest file, make corrections to AF 
      to be used
    inputBinding:
      position: 102
      prefix: --purity
  - id: tum_af
    type:
      - 'null'
      - float
    doc: The minimum frequency of the alternate allele in the tumor sample
    inputBinding:
      position: 102
      prefix: --tumAF
  - id: tum_count
    type:
      - 'null'
      - int
    doc: The minimum count of the alternate allele in the tumor sample
    inputBinding:
      position: 102
      prefix: --tumCount
  - id: tum_dp
    type:
      - 'null'
      - int
    doc: The minimum depth allowed in the tumor sample to believe somatic
    inputBinding:
      position: 102
      prefix: --tumDP
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
stdout: oncogemini_set_somatic.out
