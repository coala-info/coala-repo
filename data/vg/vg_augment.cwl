cwlVersion: v1.2
class: CommandLineTool
baseCommand: vg augment
label: vg_augment
doc: "Embed GAM alignments into a graph to facilitate variant calling\n\nTool homepage:
  https://github.com/vgteam/vg"
inputs:
  - id: graph_file
    type: File
    doc: Input graph file
    inputBinding:
      position: 1
  - id: alignment_gam_file
    type:
      - 'null'
      - File
    doc: Input alignment GAM file
    inputBinding:
      position: 2
  - id: edges_only
    type:
      - 'null'
      - boolean
    doc: only edges implied by reads, ignoring edits
    inputBinding:
      position: 103
      prefix: --edges-only
  - id: expected_cov
    type:
      - 'null'
      - int
    doc: expected coverage, used for memory tuning
    default: 128
    inputBinding:
      position: 103
      prefix: --expected-cov
  - id: gaf_format
    type:
      - 'null'
      - boolean
    doc: expect (and write) GAF instead of GAM
    inputBinding:
      position: 103
      prefix: --gaf
  - id: include_gt_file
    type:
      - 'null'
      - File
    doc: merge only alleles in called genotypes into graph
    inputBinding:
      position: 103
      prefix: --include-gt
  - id: include_loci_file
    type:
      - 'null'
      - File
    doc: merge all alleles in loci into the graph
    inputBinding:
      position: 103
      prefix: --include-loci
  - id: include_paths
    type:
      - 'null'
      - boolean
    doc: merge paths implied by alignments into the graph
    inputBinding:
      position: 103
      prefix: --include-paths
  - id: keep_softclips
    type:
      - 'null'
      - boolean
    doc: include softclips from alignments (cut by default)
    inputBinding:
      position: 103
      prefix: --keep-softclips
  - id: label_paths
    type:
      - 'null'
      - boolean
    doc: use alignments only to label graph, not augment
    inputBinding:
      position: 103
      prefix: --label-paths
  - id: max_n
    type:
      - 'null'
      - float
    doc: maximum fraction of N bases in an edit for it to be included
    default: 0.25
    inputBinding:
      position: 103
      prefix: --max-n
  - id: min_baseq
    type:
      - 'null'
      - int
    doc: ignore edits with mean base quality < N
    inputBinding:
      position: 103
      prefix: --min-baseq
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: minimum coverage of a breakpoint required for it to be added to the 
      graph
    inputBinding:
      position: 103
      prefix: --min-coverage
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: ignore alignments with mapping quality < N
    inputBinding:
      position: 103
      prefix: --min-mapq
  - id: progress
    type:
      - 'null'
      - boolean
    doc: show progress
    inputBinding:
      position: 103
      prefix: --progress
  - id: subgraph
    type:
      - 'null'
      - boolean
    doc: graph is a subgraph of the one used to create GAM. ignore alignments 
      with missing nodes
    inputBinding:
      position: 103
      prefix: --subgraph
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads (for 1st pass with -m or -q)
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print info and warnings about VCF generation
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: augmented_graph_vg_file
    type:
      - 'null'
      - File
    doc: Output augmented graph file
    outputBinding:
      glob: '*.out'
  - id: translation_file
    type:
      - 'null'
      - File
    doc: save translations from augmented back to base graph
    outputBinding:
      glob: $(inputs.translation_file)
  - id: alignment_out_file
    type:
      - 'null'
      - File
    doc: save augmented GAM reads
    outputBinding:
      glob: $(inputs.alignment_out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
