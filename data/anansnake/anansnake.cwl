cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake
label: anansnake
doc: "Snakemake is a Python based language and execution environment for GNU Make-like
  workflows.\n\nTool homepage: https://github.com/vanheeringen-lab/anansnake"
inputs:
  - id: target
    type:
      - 'null'
      - type: array
        items: string
    doc: Targets to build. May be rules or files.
    inputBinding:
      position: 1
  - id: cache
    type:
      - 'null'
      - type: array
        items: string
    doc: Store output files of given rules in a central cache.
    inputBinding:
      position: 102
      prefix: --cache
  - id: conda_prefix
    type:
      - 'null'
      - Directory
    doc: Specify a directory in which the 'conda' and 'conda-archive' 
      directories are created.
    inputBinding:
      position: 102
      prefix: --conda-prefix
  - id: config
    type:
      - 'null'
      - type: array
        items: string
    doc: Set or overwrite values in the workflow config object.
    inputBinding:
      position: 102
      prefix: --config
  - id: configfile
    type:
      - 'null'
      - type: array
        items: File
    doc: Specify or overwrite the config file of the workflow.
    inputBinding:
      position: 102
      prefix: --configfile
  - id: cores
    type:
      - 'null'
      - int
    doc: Use at most N CPU cores/jobs in parallel.
    inputBinding:
      position: 102
      prefix: --cores
  - id: dag
    type:
      - 'null'
      - boolean
    doc: Do not execute anything and print the directed acyclic graph of jobs in
      the dot language.
    inputBinding:
      position: 102
      prefix: --dag
  - id: directory
    type:
      - 'null'
      - Directory
    doc: Specify working directory.
    inputBinding:
      position: 102
      prefix: --directory
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Do not execute anything, and display what would be done.
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force the execution of the selected target or the first rule.
    inputBinding:
      position: 102
      prefix: --force
  - id: forceall
    type:
      - 'null'
      - boolean
    doc: Force the execution of the selected rule and all rules it is dependent 
      on.
    inputBinding:
      position: 102
      prefix: --forceall
  - id: jobs
    type:
      - 'null'
      - int
    doc: Use at most N CPU cluster/cloud jobs in parallel.
    inputBinding:
      position: 102
      prefix: --jobs
  - id: keep_going
    type:
      - 'null'
      - boolean
    doc: Go on with independent jobs if a job fails.
    inputBinding:
      position: 102
      prefix: --keep-going
  - id: latency_wait
    type:
      - 'null'
      - int
    doc: Wait given seconds if an output file of a job is not present after the 
      job finished.
    inputBinding:
      position: 102
      prefix: --latency-wait
  - id: local_cores
    type:
      - 'null'
      - int
    doc: In cluster/cloud mode, use at most N cores of the host machine in 
      parallel.
    inputBinding:
      position: 102
      prefix: --local-cores
  - id: max_threads
    type:
      - 'null'
      - int
    doc: Define a global maximum number of threads available to any rule.
    inputBinding:
      position: 102
      prefix: --max-threads
  - id: profile
    type:
      - 'null'
      - string
    doc: Name of profile to use for configuring Snakemake.
    inputBinding:
      position: 102
      prefix: --profile
  - id: rerun_incomplete
    type:
      - 'null'
      - boolean
    doc: Re-run all jobs the output of which is recognized as incomplete.
    inputBinding:
      position: 102
      prefix: --rerun-incomplete
  - id: rerun_triggers
    type:
      - 'null'
      - type: array
        items: string
    doc: Define what triggers the rerunning of a job.
    inputBinding:
      position: 102
      prefix: --rerun-triggers
  - id: resources
    type:
      - 'null'
      - type: array
        items: string
    doc: Define additional resources that shall constrain the scheduling.
    inputBinding:
      position: 102
      prefix: --resources
  - id: set_threads
    type:
      - 'null'
      - type: array
        items: string
    doc: Overwrite thread usage of rules.
    inputBinding:
      position: 102
      prefix: --set-threads
  - id: singularity_prefix
    type:
      - 'null'
      - Directory
    doc: Specify a directory in which singularity images will be stored.
    inputBinding:
      position: 102
      prefix: --singularity-prefix
  - id: snakefile
    type:
      - 'null'
      - File
    doc: The workflow definition in form of a snakefile.
    inputBinding:
      position: 102
      prefix: --snakefile
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Print a summary of all files created by the workflow.
    inputBinding:
      position: 102
      prefix: --summary
  - id: touch
    type:
      - 'null'
      - boolean
    doc: Touch output files instead of running their commands.
    inputBinding:
      position: 102
      prefix: --touch
  - id: unlock
    type:
      - 'null'
      - boolean
    doc: Remove a lock on the working directory.
    inputBinding:
      position: 102
      prefix: --unlock
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: If defined in the rule, run job in a conda environment.
    inputBinding:
      position: 102
      prefix: --use-conda
  - id: use_singularity
    type:
      - 'null'
      - boolean
    doc: If defined in the rule, run job within a singularity container.
    inputBinding:
      position: 102
      prefix: --use-singularity
outputs:
  - id: report
    type:
      - 'null'
      - File
    doc: Create an HTML report with results and statistics.
    outputBinding:
      glob: $(inputs.report)
  - id: export_cwl
    type:
      - 'null'
      - File
    doc: Compile workflow to CWL and store it in given FILE.
    outputBinding:
      glob: $(inputs.export_cwl)
  - id: archive
    type:
      - 'null'
      - File
    doc: Archive the workflow into the given tar archive FILE.
    outputBinding:
      glob: $(inputs.archive)
  - id: stats
    type:
      - 'null'
      - File
    doc: Write stats about Snakefile execution in JSON format to the given file.
    outputBinding:
      glob: $(inputs.stats)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anansnake:0.1.0--pyh7cba7a3_0
