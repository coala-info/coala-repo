cwlVersion: v1.2
class: CommandLineTool
baseCommand: mkprimer
label: mkdesigner_mkprimer
doc: "MKDesigner version 0.5.3\n\nTool homepage: https://github.com/KChigira/mkdesigner/"
inputs:
  - id: blast_timeout
    type:
      - 'null'
      - float
    doc: "If the process of primer specificity checking by BLAST\n               \
      \         took time more than this parameter,\n                        the variants
      considered to be non-specific.\n                        default: 60.0 (sec)"
    inputBinding:
      position: 101
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of CPUs to use.
    inputBinding:
      position: 101
  - id: limit
    type:
      - 'null'
      - int
    doc: "The upper limit of the number of primer design attempts.\n             \
      \           A large number will take a long time to calculate,\n           \
      \             but a small number may miss useful markers.\n                \
      \        default: 10000"
    inputBinding:
      position: 101
      prefix: --limit
  - id: margin
    type:
      - 'null'
      - int
    doc: "Minimum distance from 3' terminal of primer to variant.\n              \
      \          default: 5"
    inputBinding:
      position: 101
  - id: max_prodlen
    type:
      - 'null'
      - int
    doc: "Maximam PCR product length.\n                        default: 280"
    inputBinding:
      position: 101
  - id: maxdep
    type:
      - 'null'
      - int
    doc: "Variants with less depth than this\n                        are judged as
      valid mutations\n                        default: 200"
    inputBinding:
      position: 101
  - id: min_prodlen
    type:
      - 'null'
      - int
    doc: 'Minimum PCR product length.default: 150'
    inputBinding:
      position: 101
  - id: mindep
    type:
      - 'null'
      - int
    doc: "Variants with more depth than this\n                        are judged as
      valid mutations\n                        default: 2"
    inputBinding:
      position: 101
  - id: mismatch_allowed
    type:
      - 'null'
      - int
    doc: "Primers with more mismatch than this\n                        are ignored
      in specificity check.\n                        default: 5"
    inputBinding:
      position: 101
  - id: mismatch_allowed_3_terminal
    type:
      - 'null'
      - int
    doc: "Primers with more mismatch than this\n                        in 5 bases
      of 3' terminal end\n                        are ignored in specificity check.\n\
      \                        default: 1"
    inputBinding:
      position: 101
  - id: name1
    type:
      type: array
      items: string
    doc: "Variety name 1.\n                        Must match VCF column names.\n\
      \                        This parameter can be specified multiple times to design
      common markers for multiple varieties."
    inputBinding:
      position: 101
      prefix: --name1
  - id: name2
    type:
      type: array
      items: string
    doc: "Variety name 2.\n                        Must match VCF column names.\n\
      \                        This parameter can be specified multiple times to design
      common markers for multiple varieties."
    inputBinding:
      position: 101
      prefix: --name2
  - id: opt_prodlen
    type:
      - 'null'
      - int
    doc: "Optical PCR product length.\n                        default: 180"
    inputBinding:
      position: 101
  - id: output_name
    type: string
    doc: "Identical name (must be unique).\n                        This will be stem
      of output directory name."
    inputBinding:
      position: 101
      prefix: --output
  - id: primer_max_size
    type:
      - 'null'
      - int
    doc: "Maximum primer size\n                        default: 26"
    inputBinding:
      position: 101
  - id: primer_min_size
    type:
      - 'null'
      - int
    doc: "Minimum primer size\n                        default: 18"
    inputBinding:
      position: 101
  - id: primer_num_consider
    type:
      - 'null'
      - int
    doc: "Primer number considering in primer3 software.\n                       \
      \ default: 3"
    inputBinding:
      position: 101
  - id: primer_opt_size
    type:
      - 'null'
      - int
    doc: "Optical primer size\n                        default: 20"
    inputBinding:
      position: 101
  - id: ref
    type: File
    doc: Reference fasta.
    inputBinding:
      position: 101
      prefix: --ref
  - id: search_span
    type:
      - 'null'
      - int
    doc: "Intervals to search for primers upstream and downstream variants.\n    \
      \                    default: 140"
    inputBinding:
      position: 101
  - id: target_position
    type:
      - 'null'
      - type: array
        items: string
    doc: "Target position where primers designed/\n                        e.g. \"\
      chr01:1000000-3500000\"\n                        If not specified, the program
      process whole genome.\n                        This parameter can be specified
      multiple times."
    inputBinding:
      position: 101
      prefix: --target
  - id: unintended_prod_size_allowed
    type:
      - 'null'
      - int
    doc: "Primer pairs producing unintended PCR product which is shorter than this\n\
      \                        are ignored in specificity check.\n               \
      \         default: 4000"
    inputBinding:
      position: 101
  - id: variant_type
    type: string
    doc: "Type of variants.\n                        SNP or INDEL are supported."
    inputBinding:
      position: 101
      prefix: --type
  - id: vcf
    type: File
    doc: "VCF file without filtering.\n                        Recommended to use
      VCF made by \"mkvcf\" command.\n                        VCF must contain GT
      and DP field."
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mkdesigner:0.5.3--pyhdfd78af_0
stdout: mkdesigner_mkprimer.out
