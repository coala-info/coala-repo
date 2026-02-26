cwlVersion: v1.2
class: CommandLineTool
baseCommand: phlame makedb
label: phlame_makedb
doc: "Build a phlame classifier database.\n\nTool homepage: https://github.com/quevan/phlame"
inputs:
  - id: core
    type:
      - 'null'
      - float
    doc: Minimum percent of samples a position must be found in (non-N) to be 
      considered.
    default: 0.9
    inputBinding:
      position: 101
      prefix: --core
  - id: input_clades
    type:
      - 'null'
      - File
    doc: Path to optional file (newline-separated) listing clades to be manually
      included in the classifier.
    inputBinding:
      position: 101
      prefix: -c
  - id: input_mutation_table
    type: File
    doc: Path to input candidate mutation table (required).
    inputBinding:
      position: 101
      prefix: -i
  - id: input_phylogeny
    type: File
    doc: Path to input phylogeny (required, newick format).
    inputBinding:
      position: 101
      prefix: -t
  - id: max_frac_ambiguous
    type:
      - 'null'
      - float
    doc: Maximum fraction of ambiguous (N) calls to include a sample.
    default: 0.5
    inputBinding:
      position: 101
      prefix: --max_frac_ambiguous
  - id: max_outgroup
    type:
      - 'null'
      - float
    doc: Maximum percent of outgroup samples a position can be found in (non-N) 
      to be considered.
    default: 0.1
    inputBinding:
      position: 101
      prefix: --max_outgroup
  - id: maxn
    type:
      - 'null'
      - float
    doc: Maximum percentage of Ns for a position to be considered.
    default: 0.1
    inputBinding:
      position: 101
      prefix: --maxn
  - id: midpoint
    type:
      - 'null'
      - boolean
    doc: Root the input tree at the midpoint.
    default: false
    inputBinding:
      position: 101
      prefix: --midpoint
  - id: min_branchlen
    type:
      - 'null'
      - float
    doc: Minimum branch length leading up to a clade.
    default: 100.0
    inputBinding:
      position: 101
      prefix: --min_branchlen
  - id: min_leaves
    type:
      - 'null'
      - int
    doc: Minimum number of samples in a clade.
    default: 3
    inputBinding:
      position: 101
      prefix: --min_leaves
  - id: min_snps
    type:
      - 'null'
      - int
    doc: Minimum number of SNPs to include a candidate clade.
    default: 10
    inputBinding:
      position: 101
      prefix: --min_snps
  - id: min_strand_cov
    type:
      - 'null'
      - int
    doc: Minimum per-strand coverage across a position to make a base call.
    default: 2
    inputBinding:
      position: 101
      prefix: --min_strand_cov
  - id: min_support
    type:
      - 'null'
      - float
    doc: Minimum bootstrap support for a clade.
    default: 0.75
    inputBinding:
      position: 101
      prefix: --min_support
  - id: minaf
    type:
      - 'null'
      - float
    doc: Minimum allele frequency to make a base call.
    default: 0.75
    inputBinding:
      position: 101
      prefix: --minAF
  - id: outgroup
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify a comma separated list of samples to be considered outgroups.
    inputBinding:
      position: 101
      prefix: --outgroup
  - id: qual
    type:
      - 'null'
      - int
    doc: Minimum MAPQ score to make a base call.
    default: -30
    inputBinding:
      position: 101
      prefix: --qual
outputs:
  - id: output_db
    type: File
    doc: Path to output classifier (required).
    outputBinding:
      glob: $(inputs.output_db)
  - id: output_clades
    type: File
    doc: Path to output clades file (required).
    outputBinding:
      glob: $(inputs.output_clades)
  - id: output_tree
    type:
      - 'null'
      - File
    doc: Path to output tree labelled with clade names.
    outputBinding:
      glob: $(inputs.output_tree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phlame:1.1.0--pyhdfd78af_0
