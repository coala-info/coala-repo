cwlVersion: v1.2
class: CommandLineTool
baseCommand: kaptive assembly
label: kaptive_assembly
doc: "In silico serotyping of assemblies\n\nTool homepage: https://kaptive.readthedocs.io/en/latest"
inputs:
  - id: db
    type: string
    doc: Kaptive database path or keyword
    inputBinding:
      position: 1
  - id: fasta
    type:
      type: array
      items: File
    doc: Assemblies in fasta(.gz|.xz|.bz2) format
    inputBinding:
      position: 2
  - id: below_threshold
    type:
      - 'null'
      - boolean
    doc: Typeable if any genes are below threshold
    default: false
    inputBinding:
      position: 103
      prefix: --below-threshold
  - id: fasta_output
    type:
      - 'null'
      - File
    doc: Turn on fasta output. Accepts a single file or a directory
    default: cwd
    inputBinding:
      position: 103
      prefix: --fasta
  - id: filter
    type:
      - 'null'
      - string
    doc: Python regular-expression to select loci to include in the database
    inputBinding:
      position: 103
      prefix: --filter
  - id: gene_threshold
    type:
      - 'null'
      - string
    doc: Species-level locus gene identity threshold
    inputBinding:
      position: 103
      prefix: --gene-threshold
  - id: json_output
    type:
      - 'null'
      - File
    doc: Turn on JSON lines output. Optionally choose file (can be existing)
    default: kaptive_results.json
    inputBinding:
      position: 103
      prefix: --json
  - id: locus_regex
    type:
      - 'null'
      - string
    doc: Python regular-expression to match locus names in db source note
    inputBinding:
      position: 103
      prefix: --locus-regex
  - id: max_other_genes
    type:
      - 'null'
      - int
    doc: Typeable if <= other genes
    default: 1
    inputBinding:
      position: 103
      prefix: --max-other-genes
  - id: min_cov
    type:
      - 'null'
      - float
    doc: Minimum gene %coverage (blen/q_len*100) to be used for scoring
    default: 50.0
    inputBinding:
      position: 103
      prefix: --min-cov
  - id: n_best
    type:
      - 'null'
      - int
    doc: Number of best loci from the 1st round of scoring to be fully aligned 
      to the assembly
    default: 2
    inputBinding:
      position: 103
      prefix: --n-best
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Suppress header line
    inputBinding:
      position: 103
      prefix: --no-header
  - id: percent_expected
    type:
      - 'null'
      - float
    doc: Typeable if >= % expected genes
    default: 50.0
    inputBinding:
      position: 103
      prefix: --percent-expected
  - id: plot_dir
    type:
      - 'null'
      - Directory
    doc: Plot results to "./{assembly}_kaptive_results.{fmt}". Optionally choose
      a directory
    default: cwd
    inputBinding:
      position: 103
      prefix: --plot
  - id: plot_fmt
    type:
      - 'null'
      - string
    doc: Format for locus plots
    default: png
    inputBinding:
      position: 103
      prefix: --plot-fmt
  - id: score_metric
    type:
      - 'null'
      - int
    doc: 'Metric for scoring each locus (0: AS, 1: mlen, 2: blen, 3: q_len)'
    default: 0
    inputBinding:
      position: 103
      prefix: --score-metric
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of alignment threads or 0 for all available
    default: 0
    inputBinding:
      position: 103
      prefix: -t
  - id: type_regex
    type:
      - 'null'
      - string
    doc: Python regular-expression to match locus types in db source note
    inputBinding:
      position: 103
      prefix: --type-regex
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print debug messages to stderr
    inputBinding:
      position: 103
      prefix: --verbose
  - id: weight_metric
    type:
      - 'null'
      - int
    doc: Weighting for the 1st stage of the scoring algorithm
    default: 3
    inputBinding:
      position: 103
      prefix: --weight-metric
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to write/append tabular results to
    outputBinding:
      glob: $(inputs.output_file)
  - id: scores_file
    type:
      - 'null'
      - File
    doc: Dump locus score matrix to tsv (typing will not be performed!). 
      Optionally choose file (can be existing)
    outputBinding:
      glob: $(inputs.scores_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kaptive:3.1.0--pyhdfd78af_0
