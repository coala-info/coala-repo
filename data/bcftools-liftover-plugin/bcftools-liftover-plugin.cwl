cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - +liftover
label: bcftools-liftover-plugin
doc: Lift over a VCF from one genome build to another.
inputs:
  - id: src_fasta_ref
    type:
      - 'null'
      - File
    doc: source reference sequence in fasta format
    inputBinding:
      position: 101
      prefix: --src-fasta-ref
  - id: fasta_ref
    type:
      - 'null'
      - File
    doc: destination reference sequence in fasta format
    inputBinding:
      position: 101
      prefix: --fasta-ref
  - id: set_cache_size
    type:
      - 'null'
      - int
    doc: select fasta cache size in bytes
    inputBinding:
      position: 101
      prefix: --set-cache-size
  - id: chain
    type:
      - 'null'
      - File
    doc: UCSC liftOver chain file
    inputBinding:
      position: 101
      prefix: --chain
  - id: max_snp_gap
    type:
      - 'null'
      - int
    doc: maximum distance to merge contiguous blocks separated by same distance
    inputBinding:
      position: 101
      prefix: --max-snp-gap
  - id: max_indel_inc
    type:
      - 'null'
      - int
    doc: maximum distance used to increase the size an indel during liftover
    inputBinding:
      position: 101
      prefix: --max-indel-inc
  - id: lift_mt
    type:
      - 'null'
      - boolean
    doc: force liftover of MT/chrMT [automatically determined from contig 
      lengths]
    inputBinding:
      position: 101
      prefix: --lift-mt
  - id: print_blocks
    type:
      - 'null'
      - string
    doc: output contiguous blocks used for the liftOver
    inputBinding:
      position: 101
      prefix: --print-blocks
  - id: no_left_align
    type:
      - 'null'
      - boolean
    doc: do not attempt to left align indels after liftover
    inputBinding:
      position: 101
      prefix: --no-left-align
  - id: reject
    type:
      - 'null'
      - string
    doc: output variants that cannot be lifted over
    inputBinding:
      position: 101
      prefix: --reject
  - id: reject_type
    type:
      - 'null'
      - string
    doc: 'u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level'
    inputBinding:
      position: 101
      prefix: --reject-type
  - id: write_src
    type:
      - 'null'
      - boolean
    doc: write the source contig/position/alleles for lifted variants
    inputBinding:
      position: 101
      prefix: --write-src
  - id: write_fail
    type:
      - 'null'
      - boolean
    doc: write whether the 5' and 3' anchors have failed to lift
    inputBinding:
      position: 101
      prefix: --write-fail
  - id: write_nw
    type:
      - 'null'
      - boolean
    doc: write the Needleman-Wunsch alignments when required
    inputBinding:
      position: 101
      prefix: --write-nw
  - id: write_reject
    type:
      - 'null'
      - boolean
    doc: write the reason variants cannot be lifted over
    inputBinding:
      position: 101
      prefix: --write-reject
  - id: fix_tags
    type:
      - 'null'
      - boolean
    doc: fix Number type for INFO/AC, INFO/AF, FORMAT/GP, and FORMAT/DS tags
    inputBinding:
      position: 101
      prefix: --fix-tags
  - id: flip_tag
    type:
      - 'null'
      - string
    doc: INFO annotation flag to record whether alleles are flipped
    inputBinding:
      position: 101
      prefix: --flip-tag
  - id: swap_tag
    type:
      - 'null'
      - string
    doc: INFO annotation to record when alleles are swapped
    inputBinding:
      position: 101
      prefix: --swap-tag
  - id: drop_tags
    type:
      - 'null'
      - type: array
        items: string
    doc: tags to drop when alleles are swapped
    inputBinding:
      position: 101
      prefix: --drop-tags
      itemSeparator: ','
  - id: ac_tags
    type:
      - 'null'
      - type: array
        items: string
    doc: AC-like tags (must be Number=A,Type=Integer/Float)
    inputBinding:
      position: 101
      prefix: --ac-tags
      itemSeparator: ','
  - id: af_tags
    type:
      - 'null'
      - type: array
        items: string
    doc: AF-like tags (must be Number=A,Type=Float)
    inputBinding:
      position: 101
      prefix: --af-tags
      itemSeparator: ','
  - id: ds_tags
    type:
      - 'null'
      - type: array
        items: string
    doc: DS-like tags (must be Number=A,Type=Float)
    inputBinding:
      position: 101
      prefix: --ds-tags
      itemSeparator: ','
  - id: gt_tags
    type:
      - 'null'
      - type: array
        items: string
    doc: tags with integers like FORMAT/GT (must be Type=Integer)
    inputBinding:
      position: 101
      prefix: --gt-tags
      itemSeparator: ','
  - id: es_tags
    type:
      - 'null'
      - type: array
        items: string
    doc: GWAS-VCF tags (must be Number=A)
    inputBinding:
      position: 101
      prefix: --es-tags
      itemSeparator: ','
outputs:
  - id: output_print_blocks
    type:
      - 'null'
      - File
    doc: output contiguous blocks used for the liftOver
    outputBinding:
      glob: $(inputs.print_blocks)
  - id: output_reject
    type:
      - 'null'
      - File
    doc: output variants that cannot be lifted over
    outputBinding:
      glob: $(inputs.reject)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools-liftover-plugin:1.22--hb66fcc3_0
s:url: https://github.com/freeseek/score
$namespaces:
  s: https://schema.org/
