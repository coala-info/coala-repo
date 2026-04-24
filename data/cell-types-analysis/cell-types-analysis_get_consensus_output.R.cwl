cwlVersion: v1.2
class: CommandLineTool
baseCommand: cell-types-analysis_get_consensus_output.R
label: cell-types-analysis_get_consensus_output.R
doc: "Generates consensus output for cell type analysis.\n\nTool homepage: https://github.com/ebi-gene-expression-group/cell-types-analysis"
inputs:
  - id: cl_dictionary
    type:
      - 'null'
      - File
    doc: Path to the mapping between labels and CL terms in .rds format
    inputBinding:
      position: 101
      prefix: --cl-dictionary
  - id: exclusions
    type:
      - 'null'
      - File
    doc: Path to the yaml file with excluded terms. Must contain fields 
      'unlabelled' and 'trivial_terms'
    inputBinding:
      position: 101
      prefix: --exclusions
  - id: include_sem_siml
    type:
      - 'null'
      - boolean
    doc: Should semantic similarity be included into combined score calculation?
      If setting to TRUE, note that this confines the options on semantic 
      similarity metric to those with range in the [0;1] interval only.
    inputBinding:
      position: 101
      prefix: --include-sem-siml
  - id: input_dir
    type: Directory
    doc: Path to the directory with standardised .tsv files from multiple 
      methods
    inputBinding:
      position: 101
      prefix: --input-dir
  - id: num_cores
    type:
      - 'null'
      - int
    doc: Number of cores to run the process on. --parallel must be set to "true"
      for this to take effect
    inputBinding:
      position: 101
      prefix: --num-cores
  - id: ontology_graph
    type:
      - 'null'
      - File
    doc: Path to the ontology graph in .obo or .xml format. Import link can also
      be provided.
    inputBinding:
      position: 101
      prefix: --ontology-graph
  - id: parallel
    type:
      - 'null'
      - boolean
    doc: 'Boolean: Should computation be run in parallel?'
    inputBinding:
      position: 101
      prefix: --parallel
  - id: semantic_sim_metric
    type:
      - 'null'
      - string
    doc: 'Semantic similarity scoring method. Must be supported by Onassis package.
      See listSimilarities()$pairwiseMeasures for a list of accepted options. NB:
      if included in combined score calculation, make sure to select a metric with
      values in the [0;1] range.'
    inputBinding:
      position: 101
      prefix: --semantic-sim-metric
  - id: sort_by_agg_score
    type:
      - 'null'
      - boolean
    doc: Should cells be sorted by their aggregated scores?
    inputBinding:
      position: 101
      prefix: --sort-by-agg-score
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Cache directory path
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: tool_table
    type: File
    doc: Path to the tool evaluation table in text format
    inputBinding:
      position: 101
      prefix: --tool-table
  - id: true_labels
    type:
      - 'null'
      - File
    doc: '(OPTIONAL) Path to the true labels tsv file in case tool performance is
      evaluated. Expected columns: cell_id, true_label, ontology_term'
    inputBinding:
      position: 101
      prefix: --true-labels
outputs:
  - id: summary_table_output_path
    type:
      - 'null'
      - File
    doc: Path to the output table with top labels and per-cell metrics in .tsv 
      format
    outputBinding:
      glob: $(inputs.summary_table_output_path)
  - id: raw_table_output_path
    type:
      - 'null'
      - File
    doc: Path to the output table with all labels in .tsv format
    outputBinding:
      glob: $(inputs.raw_table_output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1
