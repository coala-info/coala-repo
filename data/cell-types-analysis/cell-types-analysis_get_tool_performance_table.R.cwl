cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/get_tool_performance_table.R
label: cell-types-analysis_get_tool_performance_table.R
doc: "Generates a performance table for cell type annotation tools.\n\nTool homepage:
  https://github.com/ebi-gene-expression-group/cell-types-analysis"
inputs:
  - id: barcode_col_pred
    type:
      - 'null'
      - string
    doc: Name of the cell id field in prediction file
    inputBinding:
      position: 101
      prefix: --barcode-col-pred
  - id: barcode_col_ref
    type:
      - 'null'
      - string
    doc: Name of the cell id field in reference file
    inputBinding:
      position: 101
      prefix: --barcode-col-ref
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
    default: 'FALSE'
    inputBinding:
      position: 101
      prefix: --include-sem-siml
  - id: input_dir
    type: Directory
    doc: Path to the directory with standardised output .tsv files from multiple
      methods
    inputBinding:
      position: 101
      prefix: --input-dir
  - id: lab_cl_mapping
    type:
      - 'null'
      - File
    doc: Path to serialised object containing cell label - CL terms mapping
    inputBinding:
      position: 101
      prefix: --lab-cl-mapping
  - id: label_column_pred
    type:
      - 'null'
      - string
    doc: Name of the label column in prediction file
    inputBinding:
      position: 101
      prefix: --label-column-pred
  - id: label_column_ref
    type:
      - 'null'
      - string
    doc: Name of the label column in reference file
    inputBinding:
      position: 101
      prefix: --label-column-ref
  - id: num_cores
    type:
      - 'null'
      - int
    doc: Number of cores to run the process on. --parallel must be set to "true"
      for this to take effect
    default: all available cores
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
    default: 'FALSE'
    inputBinding:
      position: 101
      prefix: --parallel
  - id: ref_file
    type: File
    doc: Path to the file with reference, "true" cell type assignments
    inputBinding:
      position: 101
      prefix: --ref-file
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
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Cache directory path
    inputBinding:
      position: 101
      prefix: --tmpdir
outputs:
  - id: output_path
    type: File
    doc: Path to the output table in .tsv format
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1
