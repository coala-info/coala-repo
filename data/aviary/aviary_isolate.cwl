cwlVersion: v1.2
class: CommandLineTool
baseCommand: aviary isolate
label: aviary_isolate
doc: "Step-down hybrid assembly using long and short reads, or assembly using only
  short or long reads.\n\nTool homepage: https://github.com/rhysnewell/aviary/"
inputs:
  - id: binning_only
    type:
      - 'null'
      - boolean
    doc: Only run up to the binning stage. Do not run SingleM, GTDB-tk, or 
      CoverM
    inputBinding:
      position: 101
      prefix: --binning-only
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
  - id: coupled
    type:
      - 'null'
      - type: array
        items: File
    doc: Forward and reverse read files in a coupled space separated list.
    default: none
    inputBinding:
      position: 101
      prefix: --coupled
  - id: default_resources
    type:
      - 'null'
      - string
    doc: 'Snakemake resources used as is found at: https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html?highlight=resources#standard-resources
      NOTE: tmpdir is handled by the `tmpdir` command line parameter.'
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
  - id: extra_binners
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Optional list of extra binning algorithms to run. Can be any combination
      of: maxbin, maxbin2, concoct, comebin, taxvamb These binners are skipped by
      default as they can have long runtimes N.B. specifying "maxbin" and "maxbin2"
      are equivalent N.B. specifying "taxvamb" will also run metabuli for contig taxonomic
      assignment'
    inputBinding:
      position: 101
      prefix: --extra-binners
  - id: extra_fastp_params
    type:
      - 'null'
      - string
    doc: Extra parameters to pass to fastp, supply as a single string e.g. 
      --extra-fastp-params "-V -e 10"
    inputBinding:
      position: 101
      prefix: --extra-fastp-params
  - id: genome_size
    type:
      - 'null'
      - int
    doc: Approximate size of the isolate genome to be assembled
    default: 5000000
    inputBinding:
      position: 101
      prefix: --genome-size
  - id: gold_standard_assembly
    type:
      - 'null'
      - type: array
        items: File
    doc: Gold standard assembly to compare either the Aviary assembly or a given
      input assembly against
    default: none
    inputBinding:
      position: 101
      prefix: --gold-standard-assembly
  - id: gsa_mappings
    type:
      - 'null'
      - string
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
  - id: guppy_model
    type:
      - 'null'
      - string
    doc: The guppy model used by medaka to perform polishing
    default: r941_min_high_g360
    inputBinding:
      position: 101
      prefix: --guppy-model
  - id: interleaved
    type:
      - 'null'
      - type: array
        items: File
    doc: A space separated list of interleaved read files
    default: none
    inputBinding:
      position: 101
      prefix: --interleaved
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
  - id: longread_type
    type:
      - 'null'
      - string
    doc: Whether the sequencing platform and technology for the longreads. "rs" 
      for PacBio RSII, "sq" for PacBio Sequel, "ccs" for PacBio CCS, "hifi" for 
      PacBio HiFi reads, "ont" for Oxford Nanopore and "ont_hq" for Oxford 
      Nanopore high quality reads (Guppy5+ or Q20)
    default: ont
    inputBinding:
      position: 101
      prefix: --longread-type
  - id: longreads
    type:
      - 'null'
      - type: array
        items: File
    doc: 'A space separated list of long-read read files. NOTE: The first file will
      be used for assembly unless --coassemble is set to True. Then all files will
      be used.'
    default: none
    inputBinding:
      position: 101
      prefix: --longreads
  - id: max_memory
    type:
      - 'null'
      - int
    doc: Maximum memory for available usage in Gigabytes
    default: 250
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
  - id: medaka_model
    type:
      - 'null'
      - string
    doc: Medaka model to use for polishing long reads.
    default: r941_min_hac_g507
    inputBinding:
      position: 101
      prefix: --medaka-model
  - id: min_bin_size
    type:
      - 'null'
      - int
    doc: Minimum bin size in base pairs for a MAG
    default: 200000
    inputBinding:
      position: 101
      prefix: --min-bin-size
  - id: min_contig_size
    type:
      - 'null'
      - int
    doc: Minimum contig size in base pairs to be considered for binning
    default: 1500
    inputBinding:
      position: 101
      prefix: --min-contig-size
  - id: min_mean_q
    type:
      - 'null'
      - int
    doc: Minimum long read mean quality threshold
    default: 10
    inputBinding:
      position: 101
      prefix: --min-mean-q
  - id: min_percent_read_identity_long
    type:
      - 'null'
      - int
    doc: Minimum percent read identity used by CoverM for long-readswhen 
      calculating genome abundances.
    default: 85
    inputBinding:
      position: 101
      prefix: --min-percent-read-identity-long
  - id: min_percent_read_identity_short
    type:
      - 'null'
      - int
    doc: Minimum percent read identity used by CoverM for short-reads when 
      calculating genome abundances.
    default: 95
    inputBinding:
      position: 101
      prefix: --min-percent-read-identity-short
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
  - id: pe1
    type:
      - 'null'
      - type: array
        items: File
    doc: A space separated list of forwards read files
    default: none
    inputBinding:
      position: 101
      prefix: --pe-1
  - id: pe2
    type:
      - 'null'
      - type: array
        items: File
    doc: A space separated list of reverse read files
    default: none
    inputBinding:
      position: 101
      prefix: --pe-2
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
    default: none
    inputBinding:
      position: 101
      prefix: --reference-filter
  - id: refinery_max_iterations
    type:
      - 'null'
      - int
    doc: Maximum number of iterations for Rosella refinery. Set to 0 to skip 
      refinery. Lower values will run faster but may result in lower quality 
      MAGs.
    default: 5
    inputBinding:
      position: 101
      prefix: --refinery-max-iterations
  - id: refinery_max_retries
    type:
      - 'null'
      - int
    doc: Maximum number of retries rosella uses to generate valid reclustering 
      within a refinery iteration. Lower values will run faster but may result 
      in lower quality MAGs.
    default: 3
    inputBinding:
      position: 101
      prefix: --refinery-max-retries
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
    default: mtime
    inputBinding:
      position: 101
      prefix: --rerun-triggers
  - id: semibin_model
    type:
      - 'null'
      - string
    doc: 'The environment model to passed to SemiBin. Can be one of: human_gut, dog_gut,
      ocean, soil, cat_gut, human_oral, mouse_gut, pig_gut, built_environment, wastewater,
      global'
    default: global
    inputBinding:
      position: 101
      prefix: --semibin-model
  - id: singlem_metapackage_path
    type:
      - 'null'
      - Directory
    doc: Path to the local SingleM metapackage
    inputBinding:
      position: 101
      prefix: --singlem-metapackage-path
  - id: skip_abundances
    type:
      - 'null'
      - boolean
    doc: Skip CoverM post-binning abundance calculations.
    inputBinding:
      position: 101
      prefix: --skip-abundances
  - id: skip_binners
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Optional list of binning algorithms to skip. Can be any combination of:
      rosella, semibin, metabat1, metabat2, metabat, vamb N.B. specifying "metabat"
      will skip both MetaBAT1 and MetaBAT2.'
    inputBinding:
      position: 101
      prefix: --skip-binners
  - id: skip_qc
    type:
      - 'null'
      - boolean
    doc: Skip quality control steps
    inputBinding:
      position: 101
      prefix: --skip-qc
  - id: skip_singlem
    type:
      - 'null'
      - boolean
    doc: Skip SingleM post-binning recovery assessment.
    inputBinding:
      position: 101
      prefix: --skip-singlem
  - id: skip_taxonomy
    type:
      - 'null'
      - boolean
    doc: Skip GTDB-tk post-binning taxonomy assignment.
    inputBinding:
      position: 101
      prefix: --skip-taxonomy
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
    default: circlator
    inputBinding:
      position: 101
      prefix: --workflow
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aviary:0.12.0--pyhdfd78af_0
