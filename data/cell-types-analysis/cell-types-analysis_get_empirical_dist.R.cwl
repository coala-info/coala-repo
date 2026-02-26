cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/get_empirical_dist.R
label: cell-types-analysis_get_empirical_dist.R
doc: "Computes empirical distributions for cell type analysis.\n\nTool homepage: https://github.com/ebi-gene-expression-group/cell-types-analysis"
inputs:
  - id: exclusions
    type:
      - 'null'
      - File
    doc: Path to the yaml file with excluded terms. Must contain fields 
      'unlabelled' and 'trivial_terms'
    inputBinding:
      position: 101
      prefix: --exclusions
  - id: input_ref_file
    type:
      - 'null'
      - File
    doc: Path to file with reference cell types
    inputBinding:
      position: 101
      prefix: --input-ref-file
  - id: lab_cl_mapping
    type:
      - 'null'
      - File
    doc: Path to serialised object containing cell label to CL terms mapping
    inputBinding:
      position: 101
      prefix: --lab-cl-mapping
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
    doc: 'Number of cores to run the process on. Default: all available cores. --parallel
      must be set to "true" for this to take effect'
    inputBinding:
      position: 101
      prefix: --num-cores
  - id: num_iterations
    type:
      - 'null'
      - int
    doc: Number of sampling iterations to construct empirical distribution
    inputBinding:
      position: 101
      prefix: --num-iterations
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
    doc: 'Boolean: Should computation be run in parallel? Default: FALSE'
    default: 'FALSE'
    inputBinding:
      position: 101
      prefix: --parallel
  - id: sample_labs
    type:
      - 'null'
      - int
    doc: Labels sample size to infer the distribution from.
    inputBinding:
      position: 101
      prefix: --sample-labs
  - id: semantic_sim_metric
    type:
      - 'null'
      - string
    doc: Semantic similarity scoring method. Must be supported by Onassis 
      package. See listSimilarities()$pairwiseMeasures for a list of accepted 
      options. Obviously must correspond to similarity metric used in other 
      scripts.
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
    type:
      - 'null'
      - File
    doc: Path to the output CDF list object in .rds format
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1
