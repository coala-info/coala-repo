cwlVersion: v1.2
class: CommandLineTool
baseCommand: aviary annotate
label: aviary_annotate
doc: "Annotate a given set of MAGs using EggNOG, GTDB-tk, and Checkm2\n\nTool homepage:
  https://github.com/rhysnewell/aviary/"
inputs:
  - id: assembly
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTA file containing scaffolded contigs of one or more metagenome 
      assemblies wishing to be passed to QUAST
    inputBinding:
      position: 101
      prefix: --assembly
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
      position: 101
      prefix: --build
  - id: checkm2_db_path
    type:
      - 'null'
      - Directory
    doc: Path to Checkm2 Database
    inputBinding:
      position: 101
      prefix: --checkm2-db-path
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
      position: 101
      prefix: --clean
  - id: cluster_retries
    type:
      - 'null'
      - int
    doc: Number of times to retry a failed job when using cluster submission 
      (see `--snakemake-profile`).
    inputBinding:
      position: 101
      prefix: --cluster-retries
  - id: conda_prefix
    type:
      - 'null'
      - Directory
    doc: Path to the location of installed conda environments, or where to 
      install new environments. Can be configured within the `configure` 
      subcommand
    inputBinding:
      position: 101
      prefix: --conda-prefix
  - id: default_resources
    type:
      - 'null'
      - string
    doc: 'Snakemake resources used as is found at: https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html?highlight=resources#standard-resources
      NOTE: tmpdir is handled by the `tmpdir` command line parameter.'
    default: ''
    inputBinding:
      position: 101
      prefix: --default-resources
  - id: disable_adapter_trimming
    type:
      - 'null'
      - boolean
    doc: Disable adapter trimming of short reads
    inputBinding:
      position: 101
      prefix: --disable-adpater-trimming
  - id: download
    type:
      - 'null'
      - type: array
        items: string
    doc: Downloads the requested GTDB, EggNOG, SingleM, CheckM2, & Metabuli 
      databases
    inputBinding:
      position: 101
      prefix: --download
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Perform snakemake dry run, tests workflow order and conda environments
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: eggnog_db_path
    type:
      - 'null'
      - Directory
    doc: Path to the local eggnog database files
    inputBinding:
      position: 101
      prefix: --eggnog-db-path
  - id: extra_fastp_params
    type:
      - 'null'
      - string
    doc: Extra parameters to pass to fastp, supply as a single string e.g. 
      --extra-fastp-params "-V -e 10"
    inputBinding:
      position: 101
      prefix: --extra-fastp-params
  - id: fasta_extension
    type:
      - 'null'
      - string
    doc: File extension of fasta files in --genome-fasta-directory
    default: fna
    inputBinding:
      position: 101
      prefix: --fasta-extension
  - id: genome_fasta_directory
    type:
      - 'null'
      - Directory
    doc: Directory containing MAGs to be annotated
    inputBinding:
      position: 101
      prefix: --genome-fasta-directory
  - id: gold_standard_assembly
    type:
      - 'null'
      - type: array
        items: File
    doc: Gold standard assembly to compare either the Aviary assembly or a given
      input assembly against
    default:
      - none
    inputBinding:
      position: 101
      prefix: --gold-standard-assembly
  - id: gsa_mappings
    type:
      - 'null'
      - File
    doc: CAMI I & II GSA mappings
    default: none
    inputBinding:
      position: 101
      prefix: --gsa-mappings
  - id: gtdb_path
    type:
      - 'null'
      - Directory
    doc: Path to the local gtdb database files
    inputBinding:
      position: 101
      prefix: --gtdb-path
  - id: keep_percent
    type:
      - 'null'
      - int
    doc: 'DEPRECATED: Percentage of reads passing quality thresholds kept by filtlong'
    default: 100
    inputBinding:
      position: 101
      prefix: --keep-percent
  - id: local_cores
    type:
      - 'null'
      - int
    doc: Maximum number of cores available for use locally. Only relevant if 
      jobs are being submitted to a cluster (e.g. see `--snakemake-profile`), in
      which case `--n-cores` will restrict requested cores in submitted jobs.
    default: 16
    inputBinding:
      position: 101
      prefix: --local-cores
  - id: max_memory
    type:
      - 'null'
      - string
    doc: Maximum memory for available usage in Gigabytes
    default: '250'
    inputBinding:
      position: 101
      prefix: --max-memory
  - id: max_short_read_length
    type:
      - 'null'
      - int
    doc: Maximum length of short reads to be kept, 0 = no maximum
    default: 0
    inputBinding:
      position: 101
      prefix: --max-short-read-length
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
      position: 101
      prefix: --max-threads
  - id: min_mean_q
    type:
      - 'null'
      - int
    doc: Minimum long read mean quality threshold
    default: 10
    inputBinding:
      position: 101
      prefix: --min-mean-q
  - id: min_read_size
    type:
      - 'null'
      - int
    doc: Minimum long read size when filtering using Filtlong
    default: 100
    inputBinding:
      position: 101
      prefix: --min-read-size
  - id: min_short_read_length
    type:
      - 'null'
      - int
    doc: Minimum length of short reads to be kept
    default: 15
    inputBinding:
      position: 101
      prefix: --min-short-read-length
  - id: n_cores
    type:
      - 'null'
      - int
    doc: Maximum number of cores available for use. Setting to multiples of 
      max_threads will allow for multiple processes to be run in parallel.
    default: 16
    inputBinding:
      position: 101
      prefix: --n-cores
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: ./
    inputBinding:
      position: 101
      prefix: --output
  - id: pplacer_threads
    type:
      - 'null'
      - int
    doc: The number of threads given to pplacer, values above `--max-threads` 
      will be scaled to equal `--max-threads`
    default: 8
    inputBinding:
      position: 101
      prefix: --pplacer-threads
  - id: quality_cutoff
    type:
      - 'null'
      - int
    doc: The short read quality value that a base is qualified. Default 15 means
      phred quality >=Q15 is qualified.
    default: 15
    inputBinding:
      position: 101
      prefix: --quality-cutoff
  - id: reference_filter
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more reference filter files to aid in the assembly. Remove 
      contaminant reads from the assembly.
    default:
      - none
    inputBinding:
      position: 101
      prefix: --reference-filter
  - id: request_gpu
    type:
      - 'null'
      - boolean
    doc: Request a GPU for use with the pipeline. This will only work if the 
      pipeline is run on a cluster
    inputBinding:
      position: 101
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
      position: 101
      prefix: --rerun-triggers
  - id: singlem_metapackage_path
    type:
      - 'null'
      - Directory
    doc: Path to the local SingleM metapackage
    inputBinding:
      position: 101
      prefix: --singlem-metapackage-path
  - id: skip_qc
    type:
      - 'null'
      - boolean
    doc: Skip quality control steps
    inputBinding:
      position: 101
      prefix: --skip-qc
  - id: snakemake_cmds
    type:
      - 'null'
      - string
    doc: "Additional commands to supplied to snakemake in the form of a single string
      e.g. \"--print-compilation True\". NOTE: Most commands in snakemake -h are valid
      but some commands may clash with commands aviary directly supplies to snakemake.
      Please make sure your additional commands don't clash."
    inputBinding:
      position: 101
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
      position: 101
      prefix: --snakemake-profile
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Path to the location that will be treated used for temporary files. If 
      none is specified, the TMPDIR environment variable will be used. Can be 
      configured within the `configure` subcommand
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: unqualified_percent_limit
    type:
      - 'null'
      - int
    doc: how many percents of bases are allowed to be unqualified. Default 40 
      means 40 percent
    default: 40
    inputBinding:
      position: 101
      prefix: --unqualified-percent-limit
  - id: workflow
    type:
      - 'null'
      - type: array
        items: string
    doc: Main workflow to run. This is the snakemake target rule to run.
    default:
      - annotate
    inputBinding:
      position: 101
      prefix: --workflow
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aviary:0.12.0--pyhdfd78af_0
stdout: aviary_annotate.out
