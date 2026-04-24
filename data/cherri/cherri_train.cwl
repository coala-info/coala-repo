cwlVersion: v1.2
class: CommandLineTool
baseCommand: cherri train
label: cherri_train
doc: "Train a Cherri model.\n\nTool homepage: https://github.com/BackofenLab/Cherri"
inputs:
  - id: list_of_replicates
    type:
      type: array
      items: File
    doc: List the ChiRA interaction summary file for each replicate
    inputBinding:
      position: 1
  - id: chrom_len_file
    type: File
    doc: "Tabular file containing data in two-column format for each chromosome: 'chrom
      name' 'chrom length'. You can directly specify 'human' or 'mouse'"
    inputBinding:
      position: 102
      prefix: --chrom_len_file
  - id: context
    type:
      - 'null'
      - int
    doc: How much context should be added at up- and downstream of the sequence.
    inputBinding:
      position: 102
      prefix: --context
  - id: context_additional
    type:
      - 'null'
      - int
    doc: 'context to extend left and right for the BED file instances. Default: 5'
    inputBinding:
      position: 102
      prefix: --context_additional
  - id: do_cv
    type:
      - 'null'
      - string
    doc: "5-fold cross validated of the pipeline will be performed using the training
      data. Set 'off' to skip. Default: 'on'"
    inputBinding:
      position: 102
      prefix: --do_cv
  - id: exp_score_th
    type:
      - 'null'
      - int
    doc: 'score threshold for the additional occupied regions [BED]. Default: 10'
    inputBinding:
      position: 102
      prefix: --exp_score_th
  - id: experiment_name
    type:
      - 'null'
      - string
    doc: Name of the data source of RRIs. Will be used for the file names.
    inputBinding:
      position: 102
      prefix: --experiment_name
  - id: filter_hybrid
    type:
      - 'null'
      - string
    doc: Filter the data for hybrids already detected by ChiRA (set 'on' to 
      filter). Default:'off'
    inputBinding:
      position: 102
      prefix: --filter_hybrid
  - id: folds
    type:
      - 'null'
      - int
    doc: 'number of folds for the cross validation. Default: 5'
    inputBinding:
      position: 102
      prefix: --folds
  - id: genome
    type: File
    doc: Path to genome FASTA file, or use the built-in download function if you
      want the human or mouse genome
    inputBinding:
      position: 102
      prefix: --genome
  - id: memory_per_thread
    type:
      - 'null'
      - int
    doc: 'Memory in MB each thread can use (total ram/threads). Default: 4300'
    inputBinding:
      position: 102
      prefix: --memoryPerThread
  - id: methods
    type:
      - 'null'
      - string
    doc: 'Methods used for model selection. Default: any'
    inputBinding:
      position: 102
      prefix: --methods
  - id: mixed
    type:
      - 'null'
      - string
    doc: "Use mixed model to combine different datasets into a combined model. Default:
      'off'"
    inputBinding:
      position: 102
      prefix: --mixed
  - id: n_jobs
    type:
      - 'null'
      - int
    doc: 'Number of jobs used for graph feature computation and model selection. Default:
      1'
    inputBinding:
      position: 102
      prefix: --n_jobs
  - id: no_sub_opt
    type:
      - 'null'
      - int
    doc: '# of interactions IntraRNA will give is possible. Default: 5'
    inputBinding:
      position: 102
      prefix: --no_sub_opt
  - id: out_name
    type:
      - 'null'
      - string
    doc: Name for the output directory, default 'date_Cherri_evaluating_RRIs'.
    inputBinding:
      position: 102
      prefix: --out_name
  - id: param_file
    type:
      - 'null'
      - File
    doc: IntaRNA parameter file.
    inputBinding:
      position: 102
      prefix: --param_file
  - id: rbp_path
    type:
      - 'null'
      - File
    doc: Path to the genomic RBP crosslink or binding site locations (in BED 
      format)
    inputBinding:
      position: 102
      prefix: --RBP_path
  - id: rri_path
    type: Directory
    doc: Path to folder storing the ChiRA interaction summary files
    inputBinding:
      position: 102
      prefix: --RRI_path
  - id: run_time
    type:
      - 'null'
      - int
    doc: 'Time used for the optimization in seconds. Default: 43200 (12h)'
    inputBinding:
      position: 102
      prefix: --run_time
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: "Set a temporary directory for autosklearn. Either proved a path or 'out'
      to set it to the output directory. Default: 'off'"
    inputBinding:
      position: 102
      prefix: --temp_dir
  - id: use_structure
    type:
      - 'null'
      - string
    doc: "Set 'off' if you want to disable graph-kernel features. Default: 'on' (when
      set to 'on' the feature optimization will be performed directly and the data
      will be stored in feature_files and no model/feature folder will be created)"
    inputBinding:
      position: 102
      prefix: --use_structure
outputs:
  - id: out_path
    type: Directory
    doc: Path to output directory where the output folder will be stored. It 
      will contain separate output folders for each step of the data, feature 
      and model preparation
    outputBinding:
      glob: $(inputs.out_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cherri:0.8--pyh7cba7a3_0
