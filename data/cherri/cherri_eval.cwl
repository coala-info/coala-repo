cwlVersion: v1.2
class: CommandLineTool
baseCommand: cherri eval
label: cherri_eval
doc: "Evaluate RRIs using a trained model.\n\nTool homepage: https://github.com/BackofenLab/Cherri"
inputs:
  - id: chrom_len_file
    type: File
    doc: "Tabular file containing data in two-column format for each chromosome: 'chrom
      name' 'chrom length'. You can directly specify 'human' or 'mouse'"
    inputBinding:
      position: 101
      prefix: --chrom_len_file
  - id: context
    type:
      - 'null'
      - int
    doc: How much context should be added at up- and downstream of the sequence.
    inputBinding:
      position: 101
      prefix: --context
  - id: eval_features
    type:
      - 'null'
      - string
    doc: If you want to start from hand-curated feature files. Use this for 
      evaluating test set performance (set 'on').
    inputBinding:
      position: 101
      prefix: --eval_features
  - id: experiment_name
    type:
      - 'null'
      - string
    doc: Name of the data source of the RRIs, e.g. experiment and organism.
    inputBinding:
      position: 101
      prefix: --experiment_name
  - id: genome
    type: File
    doc: Path to genome FASTA file, or use the built-in download function if you
      want the human or mouse genome
    inputBinding:
      position: 101
      prefix: --genome
  - id: model_file
    type: File
    doc: Set path to the model which should be used for evaluation
    inputBinding:
      position: 101
      prefix: --model_file
  - id: model_params
    type: File
    doc: Set path to the feature file of the given model
    inputBinding:
      position: 101
      prefix: --model_params
  - id: n_jobs
    type:
      - 'null'
      - int
    doc: Number of jobs used for graph feature computation.
    inputBinding:
      position: 101
      prefix: --n_jobs
  - id: occupied_regions
    type:
      - 'null'
      - File
    doc: Path to occupied regions python object file containing a dictionary
    inputBinding:
      position: 101
      prefix: --occupied_regions
  - id: out_name
    type:
      - 'null'
      - string
    doc: Name for the output directory.
    inputBinding:
      position: 101
      prefix: --out_name
  - id: param_file
    type:
      - 'null'
      - File
    doc: 'IntaRNA parameter file. Default: file in path_to_cherri_folder/Cherri/rrieval/IntaRNA_param'
    inputBinding:
      position: 101
      prefix: --param_file
  - id: rris_table
    type: File
    doc: Table containing all RRIs that should be evaluated in the correct 
      format
    inputBinding:
      position: 101
      prefix: --RRIs_table
  - id: use_structure
    type:
      - 'null'
      - string
    doc: Set 'off' if you want to disable structure.
    inputBinding:
      position: 101
      prefix: --use_structure
outputs:
  - id: out_path
    type: Directory
    doc: Path to output directory where the output folder will be stored. It 
      will contain separate output folders for each step of the data and feature
      preparation as well as the evaluated instances
    outputBinding:
      glob: $(inputs.out_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cherri:0.8--pyh7cba7a3_0
