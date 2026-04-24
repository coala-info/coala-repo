cwlVersion: v1.2
class: CommandLineTool
baseCommand: pargenes.py
label: pargenes_pargenes.py
doc: "A tool for parallel phylogenomic analyses using RAxML-NG and ModelTest-NG.\n
  \nTool homepage: https://github.com/BenoitMorel/ParGenes"
inputs:
  - id: alignments_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing the fasta files
    inputBinding:
      position: 101
      prefix: --alignments-dir
  - id: astral_global_parameters
    type:
      - 'null'
      - File
    doc: A file containing additional parameters to pass to astral
    inputBinding:
      position: 101
      prefix: --astral-global-parameters
  - id: auto_mre
    type:
      - 'null'
      - boolean
    doc: Stop computing bootstrap trees after autoMRE bootstrap convergence test.
      You have to specify the maximum number of bootstrap trees with -b or --bs-tree
    inputBinding:
      position: 101
      prefix: --autoMRE
  - id: bs_trees
    type:
      - 'null'
      - int
    doc: The number of bootstrap trees to compute
    inputBinding:
      position: 101
      prefix: --bs-trees
  - id: continue
    type:
      - 'null'
      - boolean
    doc: Allow pargenes to continue the analysis from the last checkpoint
    inputBinding:
      position: 101
      prefix: --continue
  - id: core_assignment
    type:
      - 'null'
      - string
    doc: Policy to decide the per-job number of cores (low favors a low per-job number
      of cores)
    inputBinding:
      position: 101
      prefix: --core-assignment
  - id: cores
    type:
      - 'null'
      - int
    doc: The number of computational cores available for computation. Should at least
      2.
    inputBinding:
      position: 101
      prefix: --cores
  - id: datatype
    type:
      - 'null'
      - string
    doc: Alignments datatype (nt or aa)
    inputBinding:
      position: 101
      prefix: --datatype
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Run the script without executing the actual commands
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: experiment_disable_jobs_sorting
    type:
      - 'null'
      - boolean
    doc: For experimenting only! Removes the sorting step in the scheduler
    inputBinding:
      position: 101
      prefix: --experiment-disable-jobs-sorting
  - id: job_failure_fatal
    type:
      - 'null'
      - boolean
    doc: Stop ParGenes when a job fails
    inputBinding:
      position: 101
      prefix: --job-failure-fatal
  - id: modeltest_binary
    type:
      - 'null'
      - File
    doc: Custom path to modeltest-ng executable.
    inputBinding:
      position: 101
      prefix: --modeltest-binary
  - id: modeltest_criteria
    type:
      - 'null'
      - string
    doc: Model selection criteria (AICc, AIC, BIC)
    inputBinding:
      position: 101
      prefix: --modeltest-criteria
  - id: modeltest_global_parameters
    type:
      - 'null'
      - File
    doc: A file containing the parameters to pass to modeltest
    inputBinding:
      position: 101
      prefix: --modeltest-global-parameters
  - id: modeltest_perjob_cores
    type:
      - 'null'
      - int
    doc: Number of cores to assign to each modeltest core (at least 4)
    inputBinding:
      position: 101
      prefix: --modeltest-perjob-cores
  - id: msa_filter
    type:
      - 'null'
      - File
    doc: A file containing the names of the msa files to process
    inputBinding:
      position: 101
      prefix: --msa-filter
  - id: parsimony_starting_trees
    type:
      - 'null'
      - int
    doc: The number of starting parsimony trees
    inputBinding:
      position: 101
      prefix: --parsimony-starting-trees
  - id: per_msa_modeltest_parameters
    type:
      - 'null'
      - File
    doc: A file containing per-msa modeltest parameters
    inputBinding:
      position: 101
      prefix: --per-msa-modeltest-parameters
  - id: per_msa_raxml_parameters
    type:
      - 'null'
      - File
    doc: A file containing per-msa raxml parameters
    inputBinding:
      position: 101
      prefix: --per-msa-raxml-parameters
  - id: percentage_jobs_double_cores
    type:
      - 'null'
      - float
    doc: Percentage (between 0 and 1) of jobs that will receive twice more cores
    inputBinding:
      position: 101
      prefix: --percentage-jobs-double-cores
  - id: random_starting_trees
    type:
      - 'null'
      - int
    doc: The number of starting trees
    inputBinding:
      position: 101
      prefix: --random-starting-trees
  - id: raxml_binary
    type:
      - 'null'
      - File
    doc: Custom path to raxml-ng executable.
    inputBinding:
      position: 101
      prefix: --raxml-binary
  - id: raxml_global_parameters
    type:
      - 'null'
      - File
    doc: A file containing the parameters to pass to raxml
    inputBinding:
      position: 101
      prefix: --raxml-global-parameters
  - id: raxml_global_parameters_string
    type:
      - 'null'
      - string
    doc: List of parameters to pass to raxml (see also --raxml-global-parameters)
    inputBinding:
      position: 101
      prefix: --raxml-global-parameters-string
  - id: retry
    type:
      - 'null'
      - int
    doc: Number of time the scheduler should try to restart after an error
    inputBinding:
      position: 101
      prefix: --retry
  - id: scheduler
    type:
      - 'null'
      - string
    doc: Expert-user only (split, onecore, fork).
    inputBinding:
      position: 101
      prefix: --scheduler
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed, for reproductibility of RAxML-NG runs. Set to 0 by default
    inputBinding:
      position: 101
      prefix: --seed
  - id: use_astral
    type:
      - 'null'
      - boolean
    doc: Infer a species tree with astral
    inputBinding:
      position: 101
      prefix: --use-astral
  - id: use_modeltest
    type:
      - 'null'
      - boolean
    doc: Autodetect the model with modeltest
    inputBinding:
      position: 101
      prefix: --use-modeltest
  - id: valgrind
    type:
      - 'null'
      - boolean
    doc: Run the scheduler with valgrind
    inputBinding:
      position: 101
      prefix: --valgrind
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pargenes:1.2.0--py37hf7b2935_0
