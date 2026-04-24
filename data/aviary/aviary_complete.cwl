cwlVersion: v1.2
class: CommandLineTool
baseCommand: aviary complete
label: aviary_complete
doc: "Performs all steps in the Aviary pipeline. Assembly > Binning > Refinement >
  Annotation > Diversity\n\nTool homepage: https://github.com/rhysnewell/aviary/"
inputs:
  - id: assembly
    type:
      - 'null'
      - File
    doc: Optional FASTA file containing scaffolded contigs of the metagenome 
      assembly
    inputBinding:
      position: 101
      prefix: --assembly
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
  - id: coassemble
    type:
      - 'null'
      - string
    doc: Specifies whether or not, when given multiple input reads, to 
      coassemble them. If False (no), Aviary will use the first set of short 
      reads and first set of long reads to perform assembly All read files will 
      still be used during the MAG recovery process for differential coverage.
    inputBinding:
      position: 101
      prefix: --coassemble
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
    doc: 'Forward and reverse read files in a coupled space separated list. NOTE:
      If performing assembly and multiple files are provided then only the first file
      will be used for assembly. If no longreads are provided then all samples will
      be co-assembled with megahit or metaspades depending on the --coassemble parameter'
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
  - id: exclude_contig_cov
    type:
      - 'null'
      - int
    doc: Automatically exclude Flye contigs with long read coverage less than or
      equal to this and less than or equal to `--exclude-contig-size`
    inputBinding:
      position: 101
      prefix: --exclude-contig-cov
  - id: exclude_contig_size
    type:
      - 'null'
      - int
    doc: Automatically exclude Flye contigs with length less than or equal to 
      this and long read coverage less than or equal to `--exclude-contig-cov`
    inputBinding:
      position: 101
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
  - id: gold_standard_assembly
    type:
      - 'null'
      - type: array
        items: File
    doc: Gold standard assembly to compare either the Aviary assembly or a given
      input assembly against
      - none
    inputBinding:
      position: 101
      prefix: --gold-standard-assembly
  - id: gsa_mappings
    type:
      - 'null'
      - string
    doc: CAMI I & II GSA mappings
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
  - id: include_contig_size
    type:
      - 'null'
      - int
    doc: Automatically include Flye contigs with length greater than or equal to
      this
    inputBinding:
      position: 101
      prefix: --include-contig-size
  - id: interleaved
    type:
      - 'null'
      - type: array
        items: File
    doc: 'A space separated list of interleaved read files NOTE: If performing assembly
      and multiple files are provided then only the first file will be used for assembly.
      If no longreads are provided then all samples will be co-assembled with megahit
      or metaspades depending on the --coassemble parameter'
    inputBinding:
      position: 101
      prefix: --interleaved
  - id: keep_percent
    type:
      - 'null'
      - int
    doc: 'DEPRECATED: Percentage of reads passing quality thresholds kept by filtlong'
    inputBinding:
      position: 101
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
      position: 101
      prefix: --kmer-sizes
  - id: local_cores
    type:
      - 'null'
      - int
    doc: Maximum number of cores available for use locally. Only relevant if 
      jobs are being submitted to a cluster (e.g. see `--snakemake-profile`), in
      which case `--n-cores` will restrict requested cores in submitted jobs.
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
    inputBinding:
      position: 101
      prefix: --longreads
  - id: max_memory
    type:
      - 'null'
      - int
    doc: Maximum memory for available usage in Gigabytes
    inputBinding:
      position: 101
      prefix: --max-memory
  - id: max_short_read_length
    type:
      - 'null'
      - int
    doc: Maximum length of short reads to be kept, 0 = no maximum
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
    inputBinding:
      position: 101
      prefix: --max-threads
  - id: medaka_model
    type:
      - 'null'
      - string
    doc: Medaka model to use for polishing long reads.
    inputBinding:
      position: 101
      prefix: --medaka-model
  - id: min_bin_size
    type:
      - 'null'
      - int
    doc: Minimum bin size in base pairs for a MAG
    inputBinding:
      position: 101
      prefix: --min-bin-size
  - id: min_contig_size
    type:
      - 'null'
      - int
    doc: Minimum contig size in base pairs to be considered for binning
    inputBinding:
      position: 101
      prefix: --min-contig-size
  - id: min_cov_long
    type:
      - 'null'
      - int
    doc: Automatically include Flye contigs with long read coverage greater than
      or equal to this. High long read coverage during assembly indicates that 
      the overlap layout consensus algorithm is more likely to be correct.
    inputBinding:
      position: 101
      prefix: --min-cov-long
  - id: min_cov_short
    type:
      - 'null'
      - int
    doc: Automatically include Flye contigs with short read coverage less than 
      or equal to this. Low coverage via short reads indicates that metaSPAdes 
      will not be able to better assemble this contig.
    inputBinding:
      position: 101
      prefix: --min-cov-short
  - id: min_mean_q
    type:
      - 'null'
      - int
    doc: Minimum long read mean quality threshold
    inputBinding:
      position: 101
      prefix: --min-mean-q
  - id: min_percent_read_identity_long
    type:
      - 'null'
      - int
    doc: Minimum percent read identity used by CoverM for long-readswhen 
      calculating genome abundances.
    inputBinding:
      position: 101
      prefix: --min-percent-read-identity-long
  - id: min_percent_read_identity_short
    type:
      - 'null'
      - int
    doc: Minimum percent read identity used by CoverM for short-reads when 
      calculating genome abundances.
    inputBinding:
      position: 101
      prefix: --min-percent-read-identity-short
  - id: min_read_size
    type:
      - 'null'
      - int
    doc: Minimum long read size when filtering using Filtlong
    inputBinding:
      position: 101
      prefix: --min-read-size
  - id: min_short_read_length
    type:
      - 'null'
      - int
    doc: Minimum length of short reads to be kept
    inputBinding:
      position: 101
      prefix: --min-short-read-length
  - id: n_cores
    type:
      - 'null'
      - int
    doc: Maximum number of cores available for use. Setting to multiples of 
      max_threads will allow for multiple processes to be run in parallel.
    inputBinding:
      position: 101
      prefix: --n-cores
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --output
  - id: pe1
    type:
      - 'null'
      - type: array
        items: File
    doc: 'A space separated list of forwards read files NOTE: If performing assembly
      and multiple files are provided then only the first file will be used for assembly.
      If no longreads are provided then all samples will be co-assembled with megahit
      or metaspades depending on the --coassemble parameter'
    inputBinding:
      position: 101
      prefix: --pe-1
  - id: pe2
    type:
      - 'null'
      - type: array
        items: File
    doc: 'A space separated list of reverse read files NOTE: If performing assembly
      and multiple files are provided then only the first file will be used for assembly.
      If no longreads are provided then all samples will be co-assembled with megahit
      or metaspades depending on the --coassemble parameter'
    inputBinding:
      position: 101
      prefix: --pe-2
  - id: pplacer_threads
    type:
      - 'null'
      - int
    doc: The number of threads given to pplacer, values above `--max-threads` 
      will be scaled to equal `--max-threads`
    inputBinding:
      position: 101
      prefix: --pplacer-threads
  - id: quality_cutoff
    type:
      - 'null'
      - int
    doc: The short read quality value that a base is qualified. Default 15 means
      phred quality >=Q15 is qualified.
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
      - none
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
      - mtime
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
    inputBinding:
      position: 101
      prefix: --unqualified-percent-limit
  - id: use_megahit
    type:
      - 'null'
      - boolean
    doc: Specifies whether or not to use megahit if multiple for short-read only
      assembly
    inputBinding:
      position: 101
      prefix: --use-megahit
  - id: use_unicycler
    type:
      - 'null'
      - boolean
    doc: Use Unicycler to re-assemble the metaSPAdes hybrid assembly. Not 
      recommended for complex metagenomes.
    inputBinding:
      position: 101
      prefix: --use-unicycler
  - id: workflow
    type:
      - 'null'
      - type: array
        items: string
    doc: Main workflow to run. This is the snakemake target rule to run.
      - get_bam_indices
      - recover_mags
      - annotate
      - lorikeet
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
stdout: aviary_complete.out
