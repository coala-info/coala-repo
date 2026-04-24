cwlVersion: v1.2
class: CommandLineTool
baseCommand: aviary batch
label: aviary_batch
doc: "Performs all steps in the Aviary pipeline on a batch file. Each line in the
  batch file is processed separately and then clustered using aviary. (Assembly >
  Binning > Refinement > Annotation > Diversity) * n_samples --> Cluster\n\nTool homepage:
  https://github.com/rhysnewell/aviary/"
inputs:
  - id: batch_file
    type: File
    doc: The tab or comma separated batch file containing the input samples to 
      assemble and/or recover MAGs from. An example batch file can be found at 
      https://rhysnewell.github.io/aviary/examples. The heading line is 
      required. The number of reads provided to each sample is flexible as is 
      the type of assembly being performed (if any). Multiple reads can be 
      supplied by providing a comma-separated list (surrounded by double quotes 
      "" if using a comma separated batch file) within the specific read column.
    inputBinding:
      position: 1
  - id: ani
    type:
      - 'null'
      - float
    doc: Overall ANI level to dereplicate at with FastANI.
    inputBinding:
      position: 102
      prefix: --ani
  - id: binning_only
    type:
      - 'null'
      - boolean
    doc: Only run up to the binning stage. Do not run SingleM, GTDB-tk, or 
      CoverM
    inputBinding:
      position: 102
      prefix: --binning-only
  - id: build
    type:
      - 'null'
      - string
    doc: Build conda environments necessary to run the pipeline, and then exit. 
      Equivalent to "--snakemake-cmds '--conda-create-envs-only True ' ". Other 
      inputs should be specified as if running normally so that the right set of
      conda environments is built.
    inputBinding:
      position: 102
  - id: checkm2_db_path
    type:
      - 'null'
      - Directory
    doc: Path to Checkm2 Database
    inputBinding:
      position: 102
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
    inputBinding:
      position: 102
      prefix: --clean
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: Cluster final output of all samples using aviary cluster if possible.
    inputBinding:
      position: 102
      prefix: --cluster
  - id: cluster_ani_values
    type:
      - 'null'
      - type: array
        items: float
    doc: The range of ANI values to perform clustering and dereplication at 
      during aviary cluster.
      - 0.99
      - 0.97
      - 0.95
    inputBinding:
      position: 102
      prefix: --cluster-ani-values
  - id: cluster_retries
    type:
      - 'null'
      - int
    doc: Number of times to retry a failed job when using cluster submission 
      (see `--snakemake-profile`).
    inputBinding:
      position: 102
  - id: coassemble
    type:
      - 'null'
      - string
    doc: Specifies whether or not, when given multiple input reads, to 
      coassemble them. If False (no), Aviary will use the first set of short 
      reads and first set of long reads to perform assembly All read files will 
      still be used during the MAG recovery process for differential coverage.
    inputBinding:
      position: 102
      prefix: --coassemble
  - id: conda_prefix
    type:
      - 'null'
      - Directory
    doc: Path to the location of installed conda environments, or where to 
      install new environments. Can be configured within the `configure` 
      subcommand
    inputBinding:
      position: 102
      prefix: --conda-prefix
  - id: default_resources
    type:
      - 'null'
      - string
    doc: 'Snakemake resources used as is found at: https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html?highlight=resources#standard-resources
      NOTE: tmpdir is handled by the `tmpdir` command line parameter.'
    inputBinding:
      position: 102
  - id: disable_adapter_trimming
    type:
      - 'null'
      - boolean
    doc: Disable adapter trimming of short reads
    inputBinding:
      position: 102
      prefix: --disable-adpater-trimming
  - id: download
    type:
      - 'null'
      - type: array
        items: string
    doc: Downloads the requested GTDB, EggNOG, SingleM, CheckM2, & Metabuli 
      databases
    inputBinding:
      position: 102
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Perform snakemake dry run, tests workflow order and conda environments
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: eggnog_db_path
    type:
      - 'null'
      - Directory
    doc: Path to the local eggnog database files
    inputBinding:
      position: 102
      prefix: --eggnog-db-path
  - id: exclude_contig_cov
    type:
      - 'null'
      - int
    doc: Automatically exclude Flye contigs with long read coverage less than or
      equal to this and less than or equal to `--exclude-contig-size`
    inputBinding:
      position: 102
      prefix: --exclude-contig-cov
  - id: exclude_contig_size
    type:
      - 'null'
      - int
    doc: Automatically exclude Flye contigs with length less than or equal to 
      this and long read coverage less than or equal to `--exclude-contig-cov`
    inputBinding:
      position: 102
      prefix: --exclude-contig-size
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
      position: 102
      prefix: --extra-binners
  - id: extra_fastp_params
    type:
      - 'null'
      - string
    doc: Extra parameters to pass to fastp, supply as a single string e.g. 
      --extra-fastp-params "-V -e 10"
    inputBinding:
      position: 102
      prefix: --extra-fastp-params
  - id: gold_standard_assembly
    type:
      - 'null'
      - type: array
        items: File
    doc: Gold standard assembly to compare either the Aviary assembly or a given
      input assembly against
      - none
    inputBinding:
      position: 102
      prefix: --gold-standard-assembly
  - id: gsa_mappings
    type:
      - 'null'
      - string
    doc: CAMI I & II GSA mappings
    inputBinding:
      position: 102
      prefix: --gsa-mappings
  - id: gtdb_path
    type:
      - 'null'
      - Directory
    doc: Path to the local gtdb database files
    inputBinding:
      position: 102
      prefix: --gtdb-path
  - id: include_contig_size
    type:
      - 'null'
      - int
    doc: Automatically include Flye contigs with length greater than or equal to
      this
    inputBinding:
      position: 102
      prefix: --include-contig-size
  - id: keep_percent
    type:
      - 'null'
      - int
    doc: 'DEPRECATED: Percentage of reads passing quality thresholds kept by filtlong'
    inputBinding:
      position: 102
      prefix: --keep-percent
  - id: kmer_sizes
    type:
      - 'null'
      - type: array
        items: string
    doc: Manually specify the kmer-sizes used by SPAdes during assembly. Space 
      separated odd integer values and less than 128 or "auto"
      - auto
    inputBinding:
      position: 102
      prefix: --kmer-sizes
  - id: local_cores
    type:
      - 'null'
      - int
    doc: Maximum number of cores available for use locally. Only relevant if 
      jobs are being submitted to a cluster (e.g. see `--snakemake-profile`), in
      which case `--n-cores` will restrict requested cores in submitted jobs.
    inputBinding:
      position: 102
      prefix: --local-cores
  - id: max_contamination
    type:
      - 'null'
      - float
    doc: Ignore genomes with more contamination than this percentage.
    inputBinding:
      position: 102
      prefix: --max-contamination
  - id: max_memory
    type:
      - 'null'
      - int
    doc: Maximum memory for available usage in Gigabytes
    inputBinding:
      position: 102
      prefix: --max-memory
  - id: max_short_read_length
    type:
      - 'null'
      - int
    doc: Maximum length of short reads to be kept, 0 = no maximum
    inputBinding:
      position: 102
      prefix: --max-short-read-length
  - id: max_threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads given to any particular process. If 
      max_threads > n_cores then n_cores will be bumped up to max_threads. 
      Useful if you want more fine grain control over the number of threads used
      by each process.
    inputBinding:
      position: 102
      prefix: --max-threads
  - id: medaka_model
    type:
      - 'null'
      - string
    doc: Medaka model to use for polishing long reads.
    inputBinding:
      position: 102
      prefix: --medaka-model
  - id: min_bin_size
    type:
      - 'null'
      - int
    doc: Minimum bin size in base pairs for a MAG
    inputBinding:
      position: 102
      prefix: --min-bin-size
  - id: min_completeness
    type:
      - 'null'
      - float
    doc: Ignore genomes with less completeness than this percentage.
    inputBinding:
      position: 102
      prefix: --min-completeness
  - id: min_contig_size
    type:
      - 'null'
      - int
    doc: Minimum contig size in base pairs to be considered for binning
    inputBinding:
      position: 102
      prefix: --min-contig-size
  - id: min_cov_long
    type:
      - 'null'
      - int
    doc: Automatically include Flye contigs with long read coverage greater than
      or equal to this. High long read coverage during assembly indicates that 
      the overlap layout consensus algorithm is more likely to be correct.
    inputBinding:
      position: 102
      prefix: --min-cov-long
  - id: min_cov_short
    type:
      - 'null'
      - int
    doc: Automatically include Flye contigs with short read coverage less than 
      or equal to this. Low coverage via short reads indicates that metaSPAdes 
      will not be able to better assemble this contig.
    inputBinding:
      position: 102
      prefix: --min-cov-short
  - id: min_mean_q
    type:
      - 'null'
      - int
    doc: Minimum long read mean quality threshold
    inputBinding:
      position: 102
      prefix: --min-mean-q
  - id: min_percent_read_identity_long
    type:
      - 'null'
      - int
    doc: Minimum percent read identity used by CoverM for long-reads when 
      calculating genome abundances.
    inputBinding:
      position: 102
      prefix: --min-percent-read-identity-long
  - id: min_percent_read_identity_short
    type:
      - 'null'
      - int
    doc: Minimum percent read identity used by CoverM for short-reads when 
      calculating genome abundances.
    inputBinding:
      position: 102
      prefix: --min-percent-read-identity-short
  - id: min_read_size
    type:
      - 'null'
      - int
    doc: Minimum long read size when filtering using Filtlong
    inputBinding:
      position: 102
      prefix: --min-read-size
  - id: min_short_read_length
    type:
      - 'null'
      - int
    doc: Minimum length of short reads to be kept
    inputBinding:
      position: 102
      prefix: --min-short-read-length
  - id: n_cores
    type:
      - 'null'
      - int
    doc: Maximum number of cores available for use. Setting to multiples of 
      max_threads will allow for multiple processes to be run in parallel.
    inputBinding:
      position: 102
      prefix: --n-cores
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 102
      prefix: -o
  - id: pggb_params
    type:
      - 'null'
      - string
    doc: Parameters to be used with pggb, must be surrounded by quotation marks 
      e.g. ''
    inputBinding:
      position: 102
      prefix: --pggb-params
  - id: pplacer_threads
    type:
      - 'null'
      - int
    doc: The number of threads given to pplacer, values above `--max-threads` 
      will be scaled to equal `--max-threads`
    inputBinding:
      position: 102
      prefix: --pplacer-threads
  - id: precluster_ani
    type:
      - 'null'
      - float
    doc: Require at least this dashing-derived ANI for preclustering and to 
      avoid FastANI on distant lineages within preclusters.
    inputBinding:
      position: 102
      prefix: --precluster-ani
  - id: precluster_method
    type:
      - 'null'
      - string
    doc: method of calculating rough ANI for dereplication. 'dashing' for 
      HyperLogLog, 'finch' for finch MinHash.
    inputBinding:
      position: 102
      prefix: --precluster-method
  - id: quality_cutoff
    type:
      - 'null'
      - int
    doc: The short read quality value that a base is qualified. Default 15 means
      phred quality >=Q15 is qualified.
    inputBinding:
      position: 102
      prefix: --quality-cutoff
  - id: reference_filter
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more reference filter files to aid in the assembly. Remove 
      contaminant reads from the assembly.
      - none
    inputBinding:
      position: 102
      prefix: --reference-filter
  - id: refinery_max_iterations
    type:
      - 'null'
      - int
    doc: Maximum number of iterations for Rosella refinery. Set to 0 to skip 
      refinery. Lower values will run faster but may result in lower quality 
      MAGs.
    inputBinding:
      position: 102
      prefix: --refinery-max-iterations
  - id: refinery_max_retries
    type:
      - 'null'
      - int
    doc: Maximum number of retries rosella uses to generate valid reclustering 
      within a refinery iteration. Lower values will run faster but may result 
      in lower quality MAGs.
    inputBinding:
      position: 102
      prefix: --refinery-max-retries
  - id: request_gpu
    type:
      - 'null'
      - boolean
    doc: Request a GPU for use with the pipeline. This will only work if the 
      pipeline is run on a cluster
    inputBinding:
      position: 102
      prefix: --request-gpu
  - id: rerun_triggers
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify which kinds of modifications will trigger rules to rerun
      - mtime
    inputBinding:
      position: 102
      prefix: --rerun-triggers
  - id: semibin_model
    type:
      - 'null'
      - string
    doc: 'The environment model to passed to SemiBin. Can be one of: human_gut, dog_gut,
      ocean, soil, cat_gut, human_oral, mouse_gut, pig_gut, built_environment, wastewater,
      global'
    inputBinding:
      position: 102
      prefix: --semibin-model
  - id: singlem_metapackage_path
    type:
      - 'null'
      - Directory
    doc: Path to the local SingleM metapackage
    inputBinding:
      position: 102
      prefix: --singlem-metapackage-path
  - id: skip_abundances
    type:
      - 'null'
      - boolean
    doc: Skip CoverM post-binning abundance calculations.
    inputBinding:
      position: 102
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
      position: 102
      prefix: --skip-binners
  - id: skip_qc
    type:
      - 'null'
      - boolean
    doc: Skip quality control steps
    inputBinding:
      position: 102
      prefix: --skip-qc
  - id: skip_singlem
    type:
      - 'null'
      - boolean
    doc: Skip SingleM post-binning recovery assessment.
    inputBinding:
      position: 102
      prefix: --skip-singlem
  - id: skip_taxonomy
    type:
      - 'null'
      - boolean
    doc: Skip GTDB-tk post-binning taxonomy assignment.
    inputBinding:
      position: 102
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
      position: 102
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
      position: 102
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Path to the location that will be treated used for temporary files. If 
      none is specified, the TMPDIR environment variable will be used. Can be 
      configured within the `configure` subcommand
    inputBinding:
      position: 102
      prefix: --tmpdir
  - id: unqualified_percent_limit
    type:
      - 'null'
      - int
    doc: how many percents of bases are allowed to be unqualified. Default 40 
      means 40 percent
    inputBinding:
      position: 102
      prefix: --unqualified-percent-limit
  - id: use_checkm2_scores
    type:
      - 'null'
      - boolean
    doc: Use CheckM2 completeness and contamination scores (if available) to 
      perform Galah dereplication
    inputBinding:
      position: 102
      prefix: --use-checkm2-scores
  - id: use_megahit
    type:
      - 'null'
      - boolean
    doc: Specifies whether or not to use megahit if multiple for short-read only
      assembly
    inputBinding:
      position: 102
      prefix: --use-megahit
  - id: use_unicycler
    type:
      - 'null'
      - boolean
    doc: Use Unicycler to re-assemble the metaSPAdes hybrid assembly. Not 
      recommended for complex metagenomes.
    inputBinding:
      position: 102
      prefix: --use-unicycler
  - id: workflow
    type:
      - 'null'
      - type: array
        items: string
    doc: Main workflow (snakemake target rule) to run for each sample
      - get_bam_indices
      - recover_mags
      - annotate
      - lorikeet
    inputBinding:
      position: 102
      prefix: --workflow
  - id: write_script
    type:
      - 'null'
      - File
    doc: Write the aviary batch Snakemake commands to a bash script and exit. 
      Useful when submitting jobs to HPC cluster with custom queueing.
    inputBinding:
      position: 102
      prefix: --write-script
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aviary:0.12.0--pyhdfd78af_0
stdout: aviary_batch.out
