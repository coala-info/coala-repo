cwlVersion: v1.2
class: CommandLineTool
baseCommand: scramble.sh
label: scramble_scramble.sh
doc: "Call mobile element insertions (and optionally deletions) from the soft-clipped\
  \ read clusters made by cluster_identifier (wrapper for SCRAMble.R).\n\nTool homepage:\
  \ https://github.com/GeneDx/scramble"
inputs:
  - id: out_name
    type: string
    doc: Output prefix (written in the working directory; the tool needs a full path, so it is
      added automatically)
    inputBinding:
      prefix: --out-name
      valueFrom: $(runtime.outdir)/$(self)
  - id: cluster_file
    type: File
    doc: Cluster file made by cluster_identifier
    inputBinding:
      prefix: --cluster-file
  - id: n_cluster
    type: ['null', int]
    doc: 'Minimum cluster size to analyze (default: 5)'
    inputBinding:
      prefix: --nCluster
  - id: indel_score
    type: ['null', int]
    doc: 'Minimum indel alignment score to call (default: 80)'
    inputBinding:
      prefix: --indel-score
  - id: mei_score
    type: ['null', int]
    doc: 'Minimum MEI alignment score to call (default: 50)'
    inputBinding:
      prefix: --mei-score
  - id: min_del_len
    type: ['null', int]
    doc: 'Minimum deletion length to call (default: 50)'
    inputBinding:
      prefix: --min-del-len
  - id: poly_a_frac
    type: ['null', double]
    doc: 'Fraction of clipped length for calling polyA tail in MEIs (default: 0.75)'
    inputBinding:
      prefix: --poly-a-frac
  - id: pct_align
    type: ['null', int]
    doc: 'Percent alignment of clipped read for calling deletions (default: 90)'
    inputBinding:
      prefix: --pct-align
  - id: poly_a_dist
    type: ['null', int]
    doc: 'How far from MEI to look for polyA tail (default: 100)'
    inputBinding:
      prefix: --poly-a-dist
  - id: install_dir
    type: ['null', string]
    doc: Resource directory (the wrapper already sets the one in the image)
    inputBinding:
      prefix: --install-dir
  - id: mei_refs
    type: ['null', File]
    doc: MEI reference file in FASTA format (the wrapper already sets the one in the image)
    inputBinding:
      prefix: --mei-refs
  - id: ref
    type: ['null', File]
    doc: Reference genome in FASTA format; needed for deletions and VCF output, and must be
      a BLAST nucleotide database (makeblastdb -parse_seqids -dbtype nucl) and a samtools .fai index, both beside it
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: .ndb
        required: false
      - pattern: .nhr
        required: false
      - pattern: .nin
        required: false
      - pattern: .njs
        required: false
      - pattern: .nog
        required: false
      - pattern: .nos
        required: false
      - pattern: .not
        required: false
      - pattern: .nsq
        required: false
      - pattern: .ntf
        required: false
      - pattern: .nto
        required: false
    inputBinding:
      prefix: --ref
  - id: no_vcf
    type: ['null', boolean]
    doc: Do not write a VCF file
    inputBinding:
      prefix: --no-vcf
  - id: eval_meis
    type: ['null', boolean]
    doc: Evaluate MEIs
    inputBinding:
      prefix: --eval-meis
  - id: eval_dels
    type: ['null', boolean]
    doc: Evaluate deletions
    inputBinding:
      prefix: --eval-dels
outputs:
  - id: output_files
    type: File[]
    doc: MEI table, predicted deletions and VCF written with the output prefix
    outputBinding:
      glob: $(inputs.out_name)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scramble:1.0.2--h031d066_1
