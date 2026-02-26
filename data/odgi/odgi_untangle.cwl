cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - odgi
  - untangle
label: odgi_untangle
doc: "Project paths into reference-relative BEDPE (optionally PAF), to decompose paralogy
  relationships.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: cut_every
    type:
      - 'null'
      - int
    doc: 'Start a segment boundary every Nbp of the sorted graph (default: 0/off).'
    default: 0
    inputBinding:
      position: 101
      prefix: --cut-every
  - id: cut_points_input
    type:
      - 'null'
      - File
    doc: A text file of node identifiers (one identifier per row) where to start
      the segment boundaries.When specified, no further starting points will be 
      added.
    inputBinding:
      position: 101
      prefix: --cut-points-input
  - id: gene_order
    type:
      - 'null'
      - boolean
    doc: Write each query as a series of target gene segments.
    inputBinding:
      position: 101
      prefix: --gene-order
  - id: gggenes_output
    type:
      - 'null'
      - boolean
    doc: Emit the output in gggenes-compatible tabular format.
    inputBinding:
      position: 101
      prefix: --gggenes-output
  - id: gggenes_schematic
    type:
      - 'null'
      - boolean
    doc: Emit the output in gggenes-compatible *schematic* tabular format, where
      each gene is rendered as 100bp.
    inputBinding:
      position: 101
      prefix: --gggenes-schematic
  - id: idx
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: max_self_coverage
    type:
      - 'null'
      - int
    doc: Skip mappings with greater than this level of self-coverage.
    inputBinding:
      position: 101
      prefix: --max-self-coverage
  - id: merge_dist
    type:
      - 'null'
      - int
    doc: Merge segments shorter than this length into previous segments.
    inputBinding:
      position: 101
      prefix: --merge-dist
  - id: min_jaccard
    type:
      - 'null'
      - float
    doc: 'Report target mappings >= the given jaccard threshold, with 0 <= F <= 1.0
      (default: 0.0).'
    default: 0.0
    inputBinding:
      position: 101
      prefix: --min-jaccard
  - id: n_best
    type:
      - 'null'
      - int
    doc: 'Report up to the Nth best target (reference) mapping for each query segment
      (default: 1).'
    default: 1
    inputBinding:
      position: 101
      prefix: --n-best
  - id: paf_output
    type:
      - 'null'
      - boolean
    doc: Emit the output in PAF format.
    inputBinding:
      position: 101
      prefix: --paf-output
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: query_path
    type:
      - 'null'
      - string
    doc: Use this query path.
    inputBinding:
      position: 101
      prefix: --query-path
  - id: query_paths
    type:
      - 'null'
      - File
    doc: Use query paths listed (one per line) in FILE.
    inputBinding:
      position: 101
      prefix: --query-paths
  - id: self_dotplot
    type:
      - 'null'
      - boolean
    doc: Render a table showing the positional dotplot of the query against 
      itself.
    inputBinding:
      position: 101
      prefix: --self-dotplot
  - id: step_index
    type:
      - 'null'
      - File
    doc: 'Load the step index from this *FILE*. The file name usually ends with *.stpidx*.
      (default: build the step index from scratch with a sampling rate of 8).'
    inputBinding:
      position: 101
      prefix: --step-index
  - id: target_path
    type:
      - 'null'
      - string
    doc: Use this target (reference) path.
    inputBinding:
      position: 101
      prefix: --target-path
  - id: target_paths
    type:
      - 'null'
      - File
    doc: Use target (reference) paths listed (one per line) in FILE.
    inputBinding:
      position: 101
      prefix: --target-paths
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: cut_points_output
    type:
      - 'null'
      - File
    doc: Emit node identifiers where segment boundaries started (one identifier 
      per row).
    outputBinding:
      glob: $(inputs.cut_points_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
