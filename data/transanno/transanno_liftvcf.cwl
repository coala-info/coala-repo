cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transanno
  - liftvcf
label: transanno_liftvcf
doc: "LiftOver VCF file\n\nTool homepage: https://github.com/informationsea/transanno"
inputs:
  - id: acceptable_deletion
    type:
      - 'null'
      - int
    doc: length of acceptable deletion
    default: 3
    inputBinding:
      position: 101
      prefix: --acceptable-deletion
  - id: acceptable_insertion
    type:
      - 'null'
      - int
    doc: length of acceptable insertion
    default: 3
    inputBinding:
      position: 101
      prefix: --acceptable-insertion
  - id: allow_multi_map
    type:
      - 'null'
      - boolean
    doc: Allow multi-map
    inputBinding:
      position: 101
      prefix: --allow-multi-map
  - id: chain
    type: File
    doc: chain file
    inputBinding:
      position: 101
      prefix: --chain
  - id: do_not_prefer_same_contig_when_multimap
    type:
      - 'null'
      - boolean
    doc: Do not prefer same name contig when a variant lifted into multiple positions.
    inputBinding:
      position: 101
      prefix: --do-not-prefer-same-contig-when-multimap
  - id: do_not_use_dot_when_alt_equal_to_ref
    type:
      - 'null'
      - boolean
    doc: Do not use dot as ALT when ALT column is equal to REF
    inputBinding:
      position: 101
      prefix: --do-not-use-dot-when-alt-equal-to-ref
  - id: ignore_fasta_length_mismatch
    type:
      - 'null'
      - boolean
    doc: Ignore length mismatch between chain and fasta file
    inputBinding:
      position: 101
      prefix: --ignore-fasta-length-mismatch
  - id: new_assembly
    type: File
    doc: New assembly FASTA (.fai file is required)
    inputBinding:
      position: 101
      prefix: --new-assembly
  - id: no_left_align_chain
    type:
      - 'null'
      - boolean
    doc: Do not run left align chain file
    inputBinding:
      position: 101
      prefix: --no-left-align-chain
  - id: no_rewrite_allele_count
    type:
      - 'null'
      - boolean
    doc: Do not rewrite AC or other count frequency info
    inputBinding:
      position: 101
      prefix: --no-rewrite-allele-count
  - id: no_rewrite_allele_frequency
    type:
      - 'null'
      - boolean
    doc: Do not rewrite AF or other allele frequency info
    inputBinding:
      position: 101
      prefix: --no-rewrite-allele-frequency
  - id: no_rewrite_format
    type:
      - 'null'
      - boolean
    doc: Do not rewrite order of FORMAT tags
    inputBinding:
      position: 101
      prefix: --no-rewrite-format
  - id: no_rewrite_gt
    type:
      - 'null'
      - boolean
    doc: Do not rewrite order of GT
    inputBinding:
      position: 101
      prefix: --no-rewrite-gt
  - id: noswap
    type:
      - 'null'
      - boolean
    doc: Do not swap ref/alt when reference allele is changed. This option is suitable
      to do liftOver clinVar, COSMIC annotations
    inputBinding:
      position: 101
      prefix: --noswap
  - id: original_assembly
    type: File
    doc: Original assembly FASTA (.fai file is required)
    inputBinding:
      position: 101
      prefix: --original-assembly
  - id: vcf
    type: File
    doc: input VCF file to liftOver
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: output
    type: File
    doc: output VCF file for succeeded to liftOver records (This file is not sorted)
    outputBinding:
      glob: $(inputs.output)
  - id: fail
    type: File
    doc: output VCF file for failed to liftOver records
    outputBinding:
      glob: $(inputs.fail)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transanno:0.4.5--h4349ce8_0
