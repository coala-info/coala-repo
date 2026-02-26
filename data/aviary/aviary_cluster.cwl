cwlVersion: v1.2
class: CommandLineTool
baseCommand: aviary cluster
label: aviary_cluster
doc: "Clusters previous aviary runs together and performsdereplication using Galah\n\
  \nTool homepage: https://github.com/rhysnewell/aviary/"
inputs:
  - id: previous_runs
    type:
      type: array
      items: Directory
    doc: The paths to the previous finished runs of Aviary. Must contain the 
      bins/checkm.out and bins/final_binsoutputs
    inputBinding:
      position: 1
  - id: workflow
    type:
      - 'null'
      - type: array
        items: string
    doc: Main workflow to run. This is the snakemake target rule to run.
    default:
      - complete_cluster
    inputBinding:
      position: 2
  - id: ani
    type:
      - 'null'
      - float
    doc: Overall ANI level to dereplicate at with FastANI.
    default: 97
    inputBinding:
      position: 103
      prefix: --ani
  - id: build
    type:
      - 'null'
      - string
    doc: Build conda environments necessary to run the pipeline, and then exit. 
      Equivalent to "--snakemake-cmds '--conda-create-envs-only True ' ". Other 
      inputs should be specified as if running normally so that the right set of
      conda environments is built.
    default: no
    inputBinding:
      position: 103
      prefix: --build
  - id: clean
    type:
      - 'null'
      - boolean
    doc: 'Clean up all temporary files. This will remove most BAM files and any FASTQ
      files generated from read filtering. Setting this to False is the equivalent
      of the --notemp option in snakemake. Useful for when running only part of a
      workflow as it avoids deleting files that would likely be needed in later parts
      of the workflow. NOTE: Not cleaning makes reruns faster but will incur the wrath
      of your sysadmin'
    default: true
    inputBinding:
      position: 103
      prefix: --clean
  - id: cluster_retries
    type:
      - 'null'
      - int
    doc: Number of times to retry a failed job when using cluster submission 
      (see `--snakemake-profile`).
    inputBinding:
      position: 103
      prefix: --cluster-retries
  - id: conda_prefix
    type:
      - 'null'
      - string
    doc: Path to the location of installed conda environments, or where to 
      install new environments. Can be configured within the `configure` 
      subcommand
    inputBinding:
      position: 103
      prefix: --conda-prefix
  - id: default_resources
    type:
      - 'null'
      - string
    doc: 'Snakemake resources used as is found at: https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html?highlight=resources#standard-resources
      NOTE: tmpdir is handled by the `tmpdir` command line parameter.'
    default: ''
    inputBinding:
      position: 103
      prefix: --default-resources
  - id: download
    type:
      - 'null'
      - type: array
        items: string
    doc: Downloads the requested GTDB, EggNOG, SingleM, CheckM2, & Metabuli 
      databases
    inputBinding:
      position: 103
      prefix: --download
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Perform snakemake dry run, tests workflow order and conda environments
    inputBinding:
      position: 103
      prefix: --dry-run
  - id: local_cores
    type:
      - 'null'
      - int
    doc: Maximum number of cores available for use locally. Only relevant if 
      jobs are being submitted to a cluster (e.g. see `--snakemake-profile`), in
      which case `--n-cores` will restrict requested cores in submitted jobs.
    default: 16
    inputBinding:
      position: 103
      prefix: --local-cores
  - id: max_contamination
    type:
      - 'null'
      - string
    doc: Ignore genomes with more contamination than this percentage.
    default: none
    inputBinding:
      position: 103
      prefix: --max-contamination
  - id: max_memory
    type:
      - 'null'
      - string
    doc: Maximum memory for available usage in Gigabytes
    default: '250'
    inputBinding:
      position: 103
      prefix: --max-memory
  - id: max_threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads given to any particular process. If 
      max_threads > n_cores then n_cores will be bumped up to max_threads. 
      Useful if you want more fine grain control over the number of threads used
      by each process.
    default: 8
    inputBinding:
      position: 103
      prefix: --max-threads
  - id: min_completeness
    type:
      - 'null'
      - string
    doc: Ignore genomes with less completeness than this percentage.
    default: none
    inputBinding:
      position: 103
      prefix: --min-completeness
  - id: n_cores
    type:
      - 'null'
      - int
    doc: Maximum number of cores available for use. Setting to multiples of 
      max_threads will allow for multiple processes to be run in parallel.
    default: 16
    inputBinding:
      position: 103
      prefix: --n-cores
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: ./
    inputBinding:
      position: 103
      prefix: --output
  - id: pggb_params
    type:
      - 'null'
      - string
    doc: Parameters to be used with pggb, must be surrounded by quotation marks 
      e.g. ''
    default: -k 79 -G 7919,8069
    inputBinding:
      position: 103
      prefix: --pggb-params
  - id: pplacer_threads
    type:
      - 'null'
      - int
    doc: The number of threads given to pplacer, values above `--max-threads` 
      will be scaled to equal `--max-threads`
    default: 8
    inputBinding:
      position: 103
      prefix: --pplacer-threads
  - id: precluster_ani
    type:
      - 'null'
      - float
    doc: Require at least this dashing-derived ANI for preclustering and to 
      avoid FastANI on distant lineages within preclusters.
    default: 95
    inputBinding:
      position: 103
      prefix: --precluster-ani
  - id: precluster_method
    type:
      - 'null'
      - string
    doc: method of calculating rough ANI for dereplication. 'dashing' for 
      HyperLogLog, 'finch' for finch MinHash.
    default: dashing
    inputBinding:
      position: 103
      prefix: --precluster-method
  - id: request_gpu
    type:
      - 'null'
      - boolean
    doc: Request a GPU for use with the pipeline. This will only work if the 
      pipeline is run on a cluster
    inputBinding:
      position: 103
      prefix: --request-gpu
  - id: rerun_triggers
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify which kinds of modifications will trigger rules to rerun
    default:
      - mtime
    inputBinding:
      position: 103
      prefix: --rerun-triggers
  - id: snakemake_cmds
    type:
      - 'null'
      - string
    doc: "Additional commands to supplied to snakemake in the form of a single string
      e.g. \"--print-compilation True\". NOTE: Most commands in snakemake -h are valid
      but some commands may clash with commands aviary directly supplies to snakemake.
      Please make sure your additional commands don't clash."
    inputBinding:
      position: 103
      prefix: --snakemake-cmds
  - id: snakemake_profile
    type:
      - 'null'
      - string
    doc: Snakemake profile (see 
      https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles) 
      Create profile as `~/.config/snakemake/[CLUSTER_PROFILE]/config.yaml`. Can
      be used to submit rules as jobs to cluster engine (see 
      https://snakemake.readthedocs.io/en/stable/executing/cluster.html), 
      requires cluster, cluster-status, jobs, cluster-cancel.
    inputBinding:
      position: 103
      prefix: --snakemake-profile
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Path to the location that will be treated used for temporary files. If 
      none is specified, the TMPDIR environment variable will be used. Can be 
      configured within the `configure` subcommand
    inputBinding:
      position: 103
      prefix: --tmpdir
  - id: use_checkm2_scores
    type:
      - 'null'
      - boolean
    doc: Use CheckM2 completeness and contamination scores (if available) to 
      perform Galah dereplication
    inputBinding:
      position: 103
      prefix: --use-checkm2-scores
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aviary:0.12.0--pyhdfd78af_0
stdout: aviary_cluster.out
