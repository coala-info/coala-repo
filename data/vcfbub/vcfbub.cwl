cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfbub
label: vcfbub
doc: "Filter vg deconstruct output using variant nesting information.\nThis uses the
  snarl tree decomposition to describe the nesting of variant bubbles.\nNesting information
  must be given in LV (level) and PS (parent snarl) tags.\n\nTool homepage: https://github.com/pangenome/vcfbub"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debugging information about which sites are removed.
    inputBinding:
      position: 101
      prefix: --debug
  - id: input
    type: File
    doc: Filter this input VCF file.
    inputBinding:
      position: 101
      prefix: --input
  - id: max_allele_length
    type:
      - 'null'
      - int
    doc: Filter sites whose max allele length is greater than LENGTH.
    inputBinding:
      position: 101
      prefix: --max-allele-length
  - id: max_level
    type:
      - 'null'
      - int
    doc: Filter sites with LV > LEVEL.
    inputBinding:
      position: 101
      prefix: --max-level
  - id: max_ref_length
    type:
      - 'null'
      - int
    doc: Filter sites whose reference allele is longer than LENGTH.
    inputBinding:
      position: 101
      prefix: --max-ref-length
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfbub:0.1.2--hc1c3326_1
stdout: vcfbub.out
