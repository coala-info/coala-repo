cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtk
  - vcfcluster
label: svtk_vcfcluster
doc: "Intersect SV called by PE/SR-based algorithms.\n\nTool homepage: https://github.com/talkowski-lab/svtk"
inputs:
  - id: filelist
    type: File
    doc: List of paths to standardized VCFS
    inputBinding:
      position: 1
  - id: blacklist
    type:
      - 'null'
      - File
    doc: "Tabix indexed bed of blacklisted regions. Any SV with\n                \
      \        a breakpoint falling inside one of these regions is\n             \
      \           filtered from output."
    inputBinding:
      position: 102
      prefix: --blacklist
  - id: dist
    type:
      - 'null'
      - int
    doc: "Maximum clustering distance. Suggested to use max of\n                 \
      \       median + 7*MAD over samples."
    inputBinding:
      position: 102
      prefix: --dist
  - id: frac
    type:
      - 'null'
      - float
    doc: Minimum reciprocal overlap between variants.
    inputBinding:
      position: 102
      prefix: --frac
  - id: ignore_svtypes
    type:
      - 'null'
      - boolean
    doc: Ignore svtypes when clustering.
    inputBinding:
      position: 102
      prefix: --ignore-svtypes
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for merged variant IDs.
    inputBinding:
      position: 102
      prefix: --prefix
  - id: preserve_genotypes
    type:
      - 'null'
      - boolean
    doc: "In a set of clustered variants, report best (highest\n                 \
      \       GQ) non-reference genotype when available."
    inputBinding:
      position: 102
      prefix: --preserve-genotypes
  - id: preserve_header
    type:
      - 'null'
      - boolean
    doc: Use header from clustering VCFs
    inputBinding:
      position: 102
      prefix: --preserve-header
  - id: preserve_ids
    type:
      - 'null'
      - boolean
    doc: "Include list of IDs of constituent records in each\n                   \
      \     cluster."
    inputBinding:
      position: 102
      prefix: --preserve-ids
  - id: region
    type:
      - 'null'
      - string
    doc: Restrict clustering to genomic region.
    inputBinding:
      position: 102
      prefix: --region
  - id: sample_overlap
    type:
      - 'null'
      - int
    doc: "Minimum sample overlap for two variants to be\n                        clustered
      together."
    inputBinding:
      position: 102
      prefix: --sample-overlap
  - id: svsize
    type:
      - 'null'
      - int
    doc: Minimum SV size to report for intrachromosomal events.
    inputBinding:
      position: 102
      prefix: --svsize
  - id: svtypes
    type:
      - 'null'
      - string
    doc: Comma delimited list of svtypes to cluster
    inputBinding:
      position: 102
      prefix: --svtypes
outputs:
  - id: fout
    type: File
    doc: Clustered VCF.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
