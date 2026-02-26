cwlVersion: v1.2
class: CommandLineTool
baseCommand: slivar expr
label: slivar_expr
doc: "Evaluate expressions on VCF/BCF files.\n\nTool homepage: https://github.com/brentp/slivar"
inputs:
  - id: alias
    type:
      - 'null'
      - File
    doc: path to file of group aliases
    inputBinding:
      position: 101
      prefix: --alias
  - id: exclude
    type:
      - 'null'
      - File
    doc: BED file of exclude regions (will never output excluded variants 
      regardless of pass-only flag)
    inputBinding:
      position: 101
      prefix: --exclude
  - id: family_expr
    type:
      - 'null'
      - string
    doc: expression(s) applied to each family where 'fam' is available with a 
      list of samples in each family from ped file.
    inputBinding:
      position: 101
      prefix: --family-expr
  - id: gnotate
    type:
      - 'null'
      - type: array
        items: File
    doc: path(s) to compressed gnotate file(s)
    inputBinding:
      position: 101
      prefix: --gnotate
  - id: group_expr
    type:
      - 'null'
      - string
    doc: 'expression(s) applied to the groups defined in the alias option [see: https://github.com/brentp/slivar/wiki/groups-in-slivar].'
    inputBinding:
      position: 101
      prefix: --group-expr
  - id: info
    type:
      - 'null'
      - string
    doc: expression using only attributes from the INFO field or variant. If 
      this does not pass trio/group/sample expressions are not applied.
    inputBinding:
      position: 101
      prefix: --info
  - id: js
    type:
      - 'null'
      - File
    doc: path to javascript functions to expose to user
    inputBinding:
      position: 101
      prefix: --js
  - id: pass_only
    type:
      - 'null'
      - boolean
    doc: only output variants that pass at least one of the filters
    inputBinding:
      position: 101
      prefix: --pass-only
  - id: ped
    type:
      - 'null'
      - File
    doc: pedigree file with family relations, sex, and affected status
    inputBinding:
      position: 101
      prefix: --ped
  - id: region
    type:
      - 'null'
      - string
    doc: optional region to limit evaluation. e.g. chr1 or 1:222-333 (or a BED 
      file of regions)
    inputBinding:
      position: 101
      prefix: --region
  - id: sample_expr
    type:
      - 'null'
      - string
    doc: expression(s) applied to each sample in the VCF.
    inputBinding:
      position: 101
      prefix: --sample-expr
  - id: skip_non_variable
    type:
      - 'null'
      - boolean
    doc: don't evaluate expression unless at least 1 sample is variable at the 
      variant this can improve speed
    inputBinding:
      position: 101
      prefix: --skip-non-variable
  - id: trio
    type:
      - 'null'
      - string
    doc: expression(s) applied to each trio where 'mom', 'dad', 'kid' labels are
      available; trios inferred from ped file.
    inputBinding:
      position: 101
      prefix: --trio
  - id: vcf
    type: File
    doc: path to VCF/BCF
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: out_vcf
    type:
      - 'null'
      - File
    doc: path to output VCF/BCF
    outputBinding:
      glob: $(inputs.out_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slivar:0.3.3--h5f107b1_0
