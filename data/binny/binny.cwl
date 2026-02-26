cwlVersion: v1.2
class: CommandLineTool
baseCommand: binny
label: binny
doc: "Run binny on target assembly.\n\nTool homepage: https://github.com/a-h-b/binny"
inputs:
  - id: assembly
    type:
      - 'null'
      - File
    doc: Path to an assembly fasta.
    default: None
    inputBinding:
      position: 101
      prefix: --assembly
  - id: bam
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Path to a bam file(s) to calculate depth from. Use wildcards for multiple
      samples, e.g.: "path/to/my/mappings/*.bam" or "path/to/my/mappings/wi th/*/different/folder/*/structure/*.bam"
      or "path/to/my/mappings/my_mapping.bam. Leave empty if you have an average depth
      per contig file to supply to binny.'
    default: None
    inputBinding:
      position: 101
      prefix: --bam
  - id: big_mem_avail
    type:
      - 'null'
      - boolean
    doc: Set to use high memory capacity computer node.
    default: false
    inputBinding:
      position: 101
      prefix: --big_mem_avail
  - id: big_mem_per_core_gb
    type:
      - 'null'
      - float
    doc: Specify the amount of memory per core for high memory capacity node. 
      Use with '--big-mem'.
    default: 26.0
    inputBinding:
      position: 101
      prefix: --big_mem_per_core_gb
  - id: cluster_submission_command
    type:
      - 'null'
      - string
    doc: Submission command of a cluster or batch system to use (Atm only slurm 
      support.
    default: '{cluster.call} {cluster.runtime}{resources.runtime} {cluster.mem_per_cpu}{resources.mem}
      {cluster.nodes} {cluster.qos} {cluster.threads}{threads} {cluster.partition}
      {cluster.stdout}'
    inputBinding:
      position: 101
      prefix: --cluster_submission_command
  - id: coassembly_mode
    type:
      - 'null'
      - string
    doc: Will use coassembly mode, starting with contigs >= 500 bp instead of 
      high threshold, decreasing, if set to 'on' or if 'auto' and multiple depth
      files are detected. Choose between, 'auto', 'on' , 'off'.
    default: auto
    inputBinding:
      position: 101
      prefix: --coassembly_mode
  - id: config_file
    type:
      - 'null'
      - File
    doc: 'Path to config file. A default config file to use as template can be found
      at: /usr/local/lib/python3.10/site- packages/binny/config/config.default.yaml.'
    default: ''
    inputBinding:
      position: 101
      prefix: --config_file
  - id: contig_depth
    type:
      - 'null'
      - File
    doc: Path to an average depth per contig tsv file. Leave empty if you supply
      a bam file for binny to calculate average contig depth from. First column 
      needs to be the contig ids, subsequent column(s) for depht(s).
    default: ''
    inputBinding:
      position: 101
      prefix: --contig_depth
  - id: db_path
    type:
      - 'null'
      - Directory
    doc: Absolute path to put binny dbs in. If left empty they will be put into 
      'database' in the binny main dir.
    default: /usr/local/lib/python3.10/site- packages/binny/database
    inputBinding:
      position: 101
      prefix: --db_path
  - id: distance_metric
    type:
      - 'null'
      - string
    doc: Distance metric for opentSNE and HDBSCAN.
    default: manhattan
    inputBinding:
      position: 101
      prefix: --distance_metric
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Perform a dry-run.
    default: false
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: extract_scmags
    type:
      - 'null'
      - boolean
    doc: Extract single contig MAGs of at least 90% purity and 92.5% 
      completeness.
    default: true
    inputBinding:
      position: 101
      prefix: --extract_scmags
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force all output files to be re-created.
    default: false
    inputBinding:
      position: 101
      prefix: --force
  - id: hdbscan_epsilon_range
    type:
      - 'null'
      - string
    doc: Increasing the HDBSCAN cluster selection epsilon beyond 0.5 is not 
      advised as it might massively increase run time, but it might help recover
      fragmented genomes that would be missed with lower settings.
    default: 0.250,0.000
    inputBinding:
      position: 101
      prefix: --hdbscan_epsilon_range
  - id: hdbscan_min_samples_range
    type:
      - 'null'
      - string
    doc: "Adapted from the HDBSCAN manual: 'Measure of how conservative the clustering
      should be. With larger values, more points will be declared as noise, and clusters
      will be restricted to progressively more dense areas.'."
    default: 1,5,10
    inputBinding:
      position: 101
      prefix: --hdbscan_min_samples_range
  - id: include_depth_initial
    type:
      - 'null'
      - boolean
    doc: Use depth as additional dimension during the initial clustering.
    default: false
    inputBinding:
      position: 101
      prefix: --include_depth_initial
  - id: include_depth_main
    type:
      - 'null'
      - boolean
    doc: Use depth as additional dimension during the main clusterings.
    default: false
    inputBinding:
      position: 101
      prefix: --include_depth_main
  - id: job_name
    type:
      - 'null'
      - string
    doc: Naming scheme for cluster job scripts.
    default: binny.{rulename}.{jobid}.sh
    inputBinding:
      position: 101
      prefix: --job_name
  - id: kmers
    type:
      - 'null'
      - string
    doc: Input a list of kmers, e.g. '2,3,4'.
    default: 2,3,4
    inputBinding:
      position: 101
      prefix: --kmers
  - id: mask_disruptive_sequences
    type:
      - 'null'
      - boolean
    doc: Toggle masking of potentially disruptive contig regions (e.g. rRNA and 
      CRISPR elements) from k-mer counting
    default: true
    inputBinding:
      position: 101
      prefix: --mask_disruptive_sequences
  - id: max_cont_length_cutoff
    type:
      - 'null'
      - int
    doc: Maximum contig length. Caps NX filtering value.
    default: 2250
    inputBinding:
      position: 101
      prefix: --max_cont_length_cutoff
  - id: max_cont_length_cutoff_marker
    type:
      - 'null'
      - int
    doc: Maximum contig length containing CheckM markers. Caps NX filtering 
      value.
    default: 2250
    inputBinding:
      position: 101
      prefix: --max_cont_length_cutoff_marker
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: Maximum number of binny iterations.
    default: 50
    inputBinding:
      position: 101
      prefix: --max_iterations
  - id: max_marker_lineage_depth_lvl
    type:
      - 'null'
      - int
    doc: "Maximum marker set lineage depth to check bin quality with:0: 'domain',
      1: 'phylum', 2: 'class', 3: 'order', 4: 'family', 5: 'genus', 6: 'species'."
    default: 2
    inputBinding:
      position: 101
      prefix: --max_marker_lineage_depth_lvl
  - id: max_n_contigs
    type:
      - 'null'
      - float
    doc: Maximum number of contigs binny uses. If the number of available 
      contigs after minimum size filtering exceeds this, binny will increase the
      minimum size threshold until the maximum is reached. Prevents use of 
      excessive amounts of memory on large assemblies.Default should ensure 
      adequate performance, adjust according to available memory.
    default: 500000.0
    inputBinding:
      position: 101
      prefix: --max_n_contigs
  - id: min_completeness
    type:
      - 'null'
      - float
    doc: Minimum value binny will lower completeness to while running.
    default: 72.5
    inputBinding:
      position: 101
      prefix: --min_completeness
  - id: min_cont_length_cutoff
    type:
      - 'null'
      - int
    doc: Minimum contig length. Caps NX filtering value.
    default: 2250
    inputBinding:
      position: 101
      prefix: --min_cont_length_cutoff
  - id: min_cont_length_cutoff_marker
    type:
      - 'null'
      - int
    doc: Minimum contig length containing CheckM markers. Caps NX filtering 
      value.
    default: 2250
    inputBinding:
      position: 101
      prefix: --min_cont_length_cutoff_marker
  - id: normal_mem_per_core_gb
    type:
      - 'null'
      - float
    doc: Specify the amount of memory per core for your system.
    default: 2.0
    inputBinding:
      position: 101
      prefix: --normal_mem_per_core_gb
  - id: nx_value
    type:
      - 'null'
      - float
    doc: binny prefilters assemblies based on N<X> value to try and take as much
      information as possible into account, while minimizing the amount of 
      noise. Be aware that, depending on the assembly quality, low values as the
      N<X> might results in leaving out a large proportion of the assembly (if 
      the max_cont_length cutoffs are set high as well).
    default: 90.0
    inputBinding:
      position: 101
      prefix: --NX_value
  - id: purity
    type:
      - 'null'
      - float
    doc: Minimum purity for bins to be selected.
    default: 95.0
    inputBinding:
      position: 101
      prefix: --purity
  - id: report
    type:
      - 'null'
      - boolean
    doc: Generate a report (it's recommended to run -c, -f and -l with -r).
    default: false
    inputBinding:
      position: 101
      prefix: --report
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample name.
    default: sample
    inputBinding:
      position: 101
      prefix: --sample
  - id: scheduler_preset_path
    type:
      - 'null'
      - File
    doc: Path to the scheduler preset file for cluster submission.
    default: /usr/local/lib/python3.10/site- 
      packages/binny/config/slurm.config.yaml
    inputBinding:
      position: 101
      prefix: --scheduler_preset_path
  - id: setup
    type:
      - 'null'
      - boolean
    doc: Setup CheckM database, Mantis and Prokka container.
    default: false
    inputBinding:
      position: 101
      prefix: --setup
  - id: start_completeness
    type:
      - 'null'
      - float
    doc: Completeness threshold binny wilt begin with.
    default: 92.5
    inputBinding:
      position: 101
      prefix: --start_completeness
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of cpus/threads to use.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Path to a temporary directory to write to. Defaults to outputdir/tmp
    default: ''
    inputBinding:
      position: 101
      prefix: --tmp_dir
  - id: unlock
    type:
      - 'null'
      - boolean
    doc: Unlock working directory (only necessary for crash/kill recovery).
    default: false
    inputBinding:
      position: 101
      prefix: --unlock
  - id: use_cluster
    type:
      - 'null'
      - boolean
    doc: Use cluster to submit jobs to instead of running locally.
    default: false
    inputBinding:
      position: 101
      prefix: --use_cluster
  - id: write_contig_data
    type:
      - 'null'
      - boolean
    doc: Write all contig data to compressed tsv. Might create large file.
    default: true
    inputBinding:
      position: 101
      prefix: --write_contig_data
outputs:
  - id: outputdir
    type:
      - 'null'
      - Directory
    doc: Path to desired output dir binny should create and store results in.
    outputBinding:
      glob: $(inputs.outputdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binny:2.2.18--pyhdfd78af_0
