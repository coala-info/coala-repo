cwlVersion: v1.2
class: CommandLineTool
baseCommand: haploclique
label: haploclique_bronkerbosch
doc: "predicts haplotypes from NGS reads.\n\nTool homepage: https://github.com/cbg-ethz/haploclique"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run. Can be 'clever' or 'bronkerbosch'.
    inputBinding:
      position: 1
  - id: bamfile
    type: File
    doc: Input BAM file
    inputBinding:
      position: 2
  - id: output
    type:
      - 'null'
      - string
    doc: Optional output file name or prefix
    inputBinding:
      position: 3
  - id: allel_frequencies
    type:
      - 'null'
      - File
    doc: Allele frequencies file
    inputBinding:
      position: 104
      prefix: --allel_frequencies
  - id: call_indels
    type:
      - 'null'
      - File
    doc: variant calling is not supported yet.
    inputBinding:
      position: 104
      prefix: --call_indels
  - id: doc_haplotypes
    type:
      - 'null'
      - int
    doc: Used in simulation studies with known haplotypes to document which 
      reads contributed to which final cliques (3 or 5).
    inputBinding:
      position: 104
      prefix: --doc_haplotypes
  - id: edge_quasi_cutoff_cliques
    type:
      - 'null'
      - float
    doc: edge calculator option
    default: 0.99
    inputBinding:
      position: 104
      prefix: --edge_quasi_cutoff_cliques
  - id: edge_quasi_cutoff_mixed
    type:
      - 'null'
      - float
    doc: edge calculator option
    default: 0.97
    inputBinding:
      position: 104
      prefix: --edge_quasi_cutoff_mixed
  - id: edge_quasi_cutoff_single
    type:
      - 'null'
      - float
    doc: edge calculator option
    default: 0.95
    inputBinding:
      position: 104
      prefix: --edge_quasi_cutoff_single
  - id: filter
    type:
      - 'null'
      - float
    doc: Filter out reads with low frequency at the end.
    default: 0.0
    inputBinding:
      position: 104
      prefix: --filter
  - id: frame_shift_merge
    type:
      - 'null'
      - boolean
    doc: Reads will be clustered with single nucleotide insertions or deletions.
      Use for PacBio data.
    inputBinding:
      position: 104
      prefix: --frame_shift_merge
  - id: indel_edge_sig_level
    type:
      - 'null'
      - float
    doc: Indel edge significance level
    default: 0.2
    inputBinding:
      position: 104
      prefix: --indel_edge_sig_level
  - id: iterations
    type:
      - 'null'
      - int
    doc: Number of iterations. haploclique will stop if the superreads converge.
    default: -1
    inputBinding:
      position: 104
      prefix: --iterations
  - id: limit_clique_size
    type:
      - 'null'
      - int
    doc: Set a threshold to limit the size of cliques.
    inputBinding:
      position: 104
      prefix: --limit_clique_size
  - id: log
    type:
      - 'null'
      - File
    doc: Write log to <file>.
    inputBinding:
      position: 104
      prefix: --log
  - id: max_cliques
    type:
      - 'null'
      - int
    doc: Set a threshold for the maximal number of cliques which should be 
      considered in the next iteration.
    inputBinding:
      position: 104
      prefix: --max_cliques
  - id: mean_and_sd_filename
    type:
      - 'null'
      - File
    doc: Required for option -I
    inputBinding:
      position: 104
      prefix: --mean_and_sd_filename
  - id: min_overlap_cliques
    type:
      - 'null'
      - float
    doc: edge calculator option
    default: 0.9
    inputBinding:
      position: 104
      prefix: --min_overlap_cliques
  - id: min_overlap_single
    type:
      - 'null'
      - float
    doc: edge calculator option
    default: 0.6
    inputBinding:
      position: 104
      prefix: --min_overlap_single
  - id: no_prob0
    type:
      - 'null'
      - boolean
    doc: ignore the tail probabilities during edge calculation in <output>.
    inputBinding:
      position: 104
      prefix: --no_prob0
  - id: no_singletons
    type:
      - 'null'
      - boolean
    doc: Filter out single read cliques after first iteration.
    inputBinding:
      position: 104
      prefix: --no_singletons
  - id: random_overlap_quality
    type:
      - 'null'
      - float
    doc: edge calculator option
    default: 0.9
    inputBinding:
      position: 104
      prefix: --random_overlap_quality
  - id: significance
    type:
      - 'null'
      - float
    doc: Filter out reads witch are below <num> standard deviations.
    default: 3.0
    inputBinding:
      position: 104
      prefix: --significance
outputs:
  - id: gff
    type:
      - 'null'
      - File
    doc: Option to create GFF File from output. <output> is used as prefix.
    outputBinding:
      glob: $(inputs.gff)
  - id: bam
    type:
      - 'null'
      - File
    doc: Option to create BAM File from output. <output> is used as prefix.
    outputBinding:
      glob: $(inputs.bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haploclique:1.3.1--h2b6358e_4
