cwlVersion: v1.2
class: CommandLineTool
baseCommand: sccaf
label: sccaf
doc: "sccaf\n\nTool homepage: https://github.com/SCCAF/sccaf"
inputs:
  - id: conf_sampling_iterations
    type:
      - 'null'
      - int
    doc: 'How many samples are taken of cells per clusters prior to the confusion
      matrix calculation.Higher numbers will produce more stable results in terms
      of rounds, but will take longer. Default: 3.'
    inputBinding:
      position: 101
      prefix: --conf-sampling-iterations
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of processors to use
    inputBinding:
      position: 101
      prefix: --cores
  - id: external_clustering_tsv
    type:
      - 'null'
      - File
    doc: Path to external clustering in TSV
    inputBinding:
      position: 101
      prefix: --external-clustering-tsv
  - id: input_file
    type:
      - 'null'
      - File
    doc: Path to input in AnnData or Loom
    inputBinding:
      position: 101
      prefix: --input-file
  - id: min_accuracy
    type:
      - 'null'
      - float
    doc: Accuracy threshold for convergence of the optimisation procedure.
    inputBinding:
      position: 101
      prefix: --min-accuracy
  - id: optimise
    type:
      - 'null'
      - boolean
    doc: Not only run assessment, but also optimise the clustering
    inputBinding:
      position: 101
      prefix: --optimise
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for clustering labels
    inputBinding:
      position: 101
      prefix: --prefix
  - id: produce_rounds_summary
    type:
      - 'null'
      - boolean
    doc: Set to produce summary files for each round of optimisation
    inputBinding:
      position: 101
      prefix: --produce-rounds-summary
  - id: resolution
    type:
      - 'null'
      - float
    doc: Resolution for running clustering when no internal or external 
      clustering is given.
    inputBinding:
      position: 101
      prefix: --resolution
  - id: skip_assessment
    type:
      - 'null'
      - boolean
    doc: If --optimise given, then this allows to optionally skip the original 
      assessment of the clustering
    inputBinding:
      position: 101
      prefix: --skip-assessment
  - id: slot_for_existing_clustering
    type:
      - 'null'
      - string
    doc: Use clustering pre-computed in the input object, available in this slot
      of the object.
    inputBinding:
      position: 101
      prefix: --slot-for-existing-clustering
  - id: undercluster_boundary
    type:
      - 'null'
      - string
    doc: Label for the underclustering boundary to use in the optimisation. It 
      should be present in the annData object
    inputBinding:
      position: 101
      prefix: --undercluster-boundary
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path for output file
    outputBinding:
      glob: $(inputs.output_file)
  - id: optimisation_plots_output
    type:
      - 'null'
      - File
    doc: PDF file output path for all optimisation plots.
    outputBinding:
      glob: $(inputs.optimisation_plots_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sccaf:0.0.10--py_0
