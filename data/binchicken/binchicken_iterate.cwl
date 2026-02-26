cwlVersion: v1.2
class: CommandLineTool
baseCommand: binchicken iterate
label: binchicken_iterate
doc: "Iterate through binning and assembly strategies.\n\nTool homepage: https://github.com/aroneys/binchicken"
inputs:
  - id: abundance_weighted
    type:
      - 'null'
      - boolean
    doc: Perform abundance-weighted analysis.
    inputBinding:
      position: 101
      prefix: --abundance-weighted
  - id: abundance_weighted_samples
    type:
      - 'null'
      - type: array
        items: string
    doc: List of sample names for abundance-weighted analysis.
    inputBinding:
      position: 101
      prefix: --abundance-weighted-samples
  - id: abundance_weighted_samples_list
    type:
      - 'null'
      - File
    doc: File containing a list of sample names for abundance-weighted analysis.
    inputBinding:
      position: 101
      prefix: --abundance-weighted-samples-list
  - id: anchor_samples
    type:
      - 'null'
      - type: array
        items: string
    doc: List of sample names to anchor coassembly.
    inputBinding:
      position: 101
      prefix: --anchor-samples
  - id: anchor_samples_list
    type:
      - 'null'
      - File
    doc: File containing a list of sample names to anchor coassembly.
    inputBinding:
      position: 101
      prefix: --anchor-samples-list
  - id: appraise_sequence_identity
    type:
      - 'null'
      - float
    doc: Sequence identity threshold for appraising.
    inputBinding:
      position: 101
      prefix: --appraise-sequence-identity
  - id: assemble_unmapped
    type:
      - 'null'
      - boolean
    doc: Assemble unmapped reads.
    inputBinding:
      position: 101
      prefix: --assemble-unmapped
  - id: assembly_strategy
    type:
      - 'null'
      - string
    doc: Assembly strategy to use.
    default: dynamic
    inputBinding:
      position: 101
      prefix: --assembly-strategy
  - id: aviary_assemble_cores
    type:
      - 'null'
      - int
    doc: Number of cores for Aviary assembly.
    inputBinding:
      position: 101
      prefix: --aviary-assemble-cores
  - id: aviary_assemble_memory
    type:
      - 'null'
      - string
    doc: Memory for Aviary assembly.
    inputBinding:
      position: 101
      prefix: --aviary-assemble-memory
  - id: aviary_checkm2_db
    type:
      - 'null'
      - Directory
    doc: Path to CheckM2 database for Aviary.
    inputBinding:
      position: 101
      prefix: --aviary-checkm2-db
  - id: aviary_extra_binners
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional binners to use with Aviary.
    inputBinding:
      position: 101
      prefix: --aviary-extra-binners
  - id: aviary_gtdbtk_db
    type:
      - 'null'
      - Directory
    doc: Path to GTDB-Tk database for Aviary.
    inputBinding:
      position: 101
      prefix: --aviary-gtdbtk-db
  - id: aviary_metabuli_db
    type:
      - 'null'
      - Directory
    doc: Path to MetaBuli database for Aviary.
    inputBinding:
      position: 101
      prefix: --aviary-metabuli-db
  - id: aviary_outputs
    type:
      - 'null'
      - type: array
        items: File
    doc: List of aviary output files.
    inputBinding:
      position: 101
      prefix: --aviary-outputs
  - id: aviary_recover_cores
    type:
      - 'null'
      - int
    doc: Number of cores for Aviary recovery.
    inputBinding:
      position: 101
      prefix: --aviary-recover-cores
  - id: aviary_recover_memory
    type:
      - 'null'
      - string
    doc: Memory for Aviary recovery.
    inputBinding:
      position: 101
      prefix: --aviary-recover-memory
  - id: aviary_request_gpu
    type:
      - 'null'
      - boolean
    doc: Request GPU for Aviary.
    inputBinding:
      position: 101
      prefix: --aviary-request-gpu
  - id: aviary_skip_binners
    type:
      - 'null'
      - type: array
        items: string
    doc: Binners to skip with Aviary.
    inputBinding:
      position: 101
      prefix: --aviary-skip-binners
  - id: aviary_snakemake_profile
    type:
      - 'null'
      - File
    doc: Snakemake profile for Aviary.
    inputBinding:
      position: 101
      prefix: --aviary-snakemake-profile
  - id: aviary_speed
    type:
      - 'null'
      - string
    doc: Speed setting for Aviary.
    default: comprehensive
    inputBinding:
      position: 101
      prefix: --aviary-speed
  - id: checkm_version
    type:
      - 'null'
      - string
    doc: Version of CheckM to use.
    inputBinding:
      position: 101
      prefix: --checkm-version
  - id: cluster_submission
    type:
      - 'null'
      - boolean
    doc: Submit jobs to a cluster.
    inputBinding:
      position: 101
      prefix: --cluster-submission
  - id: coassemble_binned
    type:
      - 'null'
      - File
    doc: Output file for binned coassembly results.
    inputBinding:
      position: 101
      prefix: --coassemble-binned
  - id: coassemble_output
    type:
      - 'null'
      - Directory
    doc: Output directory for coassembly.
    inputBinding:
      position: 101
      prefix: --coassemble-output
  - id: coassemble_unbinned
    type:
      - 'null'
      - File
    doc: Output file for unbinned coassembly results.
    inputBinding:
      position: 101
      prefix: --coassemble-unbinned
  - id: coassembly_samples
    type:
      - 'null'
      - type: array
        items: string
    doc: List of sample names for coassembly.
    inputBinding:
      position: 101
      prefix: --coassembly-samples
  - id: coassembly_samples_list
    type:
      - 'null'
      - File
    doc: File containing a list of sample names for coassembly.
    inputBinding:
      position: 101
      prefix: --coassembly-samples-list
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of CPU cores to use.
    inputBinding:
      position: 101
      prefix: --cores
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug mode.
    inputBinding:
      position: 101
      prefix: --debug
  - id: download_limit
    type:
      - 'null'
      - int
    doc: Limit for data download.
    inputBinding:
      position: 101
      prefix: --download-limit
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: Perform a dry run without executing commands.
    inputBinding:
      position: 101
      prefix: --dryrun
  - id: elusive_clusters
    type:
      - 'null'
      - type: array
        items: File
    doc: List of elusive cluster files.
    inputBinding:
      position: 101
      prefix: --elusive-clusters
  - id: exclude_coassemblies
    type:
      - 'null'
      - type: array
        items: string
    doc: List of sample names to exclude from coassemblies.
    inputBinding:
      position: 101
      prefix: --exclude-coassemblies
  - id: exclude_coassemblies_list
    type:
      - 'null'
      - File
    doc: File containing a list of sample names to exclude from coassemblies.
    inputBinding:
      position: 101
      prefix: --exclude-coassemblies-list
  - id: file_hierarchy
    type:
      - 'null'
      - string
    doc: File hierarchy strategy.
    default: large
    inputBinding:
      position: 101
      prefix: --file-hierarchy
  - id: file_hierarchy_chars
    type:
      - 'null'
      - int
    doc: Number of characters for file hierarchy.
    inputBinding:
      position: 101
      prefix: --file-hierarchy-chars
  - id: file_hierarchy_depth
    type:
      - 'null'
      - int
    doc: Depth of file hierarchy.
    inputBinding:
      position: 101
      prefix: --file-hierarchy-depth
  - id: forward
    type:
      - 'null'
      - type: array
        items: File
    doc: List of forward read files.
    inputBinding:
      position: 101
      prefix: --forward
  - id: forward_list
    type:
      - 'null'
      - File
    doc: File containing a list of forward read files.
    inputBinding:
      position: 101
      prefix: --forward-list
  - id: full_help
    type:
      - 'null'
      - boolean
    doc: Display full help message.
    inputBinding:
      position: 101
      prefix: --full-help
  - id: full_help_roff
    type:
      - 'null'
      - boolean
    doc: Display full help message in roff format.
    inputBinding:
      position: 101
      prefix: --full-help-roff
  - id: genome_singlem
    type:
      - 'null'
      - File
    doc: Single genome file for singlem analysis.
    inputBinding:
      position: 101
      prefix: --genome-singlem
  - id: genome_transcripts
    type:
      - 'null'
      - type: array
        items: File
    doc: List of genome transcript files.
    inputBinding:
      position: 101
      prefix: --genome-transcripts
  - id: genome_transcripts_list
    type:
      - 'null'
      - File
    doc: File containing a list of genome transcript files.
    inputBinding:
      position: 101
      prefix: --genome-transcripts-list
  - id: genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: List of genome files.
    inputBinding:
      position: 101
      prefix: --genomes
  - id: genomes_list
    type:
      - 'null'
      - File
    doc: File containing a list of genome files.
    inputBinding:
      position: 101
      prefix: --genomes-list
  - id: iteration
    type:
      - 'null'
      - int
    doc: Iteration number for the process.
    inputBinding:
      position: 101
      prefix: --iteration
  - id: kmer_precluster
    type:
      - 'null'
      - string
    doc: K-mer preclustering strategy.
    default: large
    inputBinding:
      position: 101
      prefix: --kmer-precluster
  - id: local_cores
    type:
      - 'null'
      - int
    doc: Number of local CPU cores to use.
    inputBinding:
      position: 101
      prefix: --local-cores
  - id: max_coassembly_samples
    type:
      - 'null'
      - int
    doc: Maximum number of samples to include in coassembly.
    inputBinding:
      position: 101
      prefix: --max-coassembly-samples
  - id: max_coassembly_size
    type:
      - 'null'
      - int
    doc: Maximum size of coassembly.
    inputBinding:
      position: 101
      prefix: --max-coassembly-size
  - id: max_contamination
    type:
      - 'null'
      - float
    doc: Maximum contamination threshold for bins.
    inputBinding:
      position: 101
      prefix: --max-contamination
  - id: max_recovery_samples
    type:
      - 'null'
      - int
    doc: Maximum number of samples for recovery.
    inputBinding:
      position: 101
      prefix: --max-recovery-samples
  - id: max_sample_combinations
    type:
      - 'null'
      - int
    doc: Maximum number of sample combinations.
    inputBinding:
      position: 101
      prefix: --max-sample-combinations
  - id: min_completeness
    type:
      - 'null'
      - float
    doc: Minimum completeness threshold for bins.
    inputBinding:
      position: 101
      prefix: --min-completeness
  - id: min_sequence_coverage
    type:
      - 'null'
      - float
    doc: Minimum sequence coverage threshold.
    inputBinding:
      position: 101
      prefix: --min-sequence-coverage
  - id: new_genome_singlem
    type:
      - 'null'
      - File
    doc: Single new genome file for singlem analysis.
    inputBinding:
      position: 101
      prefix: --new-genome-singlem
  - id: new_genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: List of new genome files.
    inputBinding:
      position: 101
      prefix: --new-genomes
  - id: new_genomes_list
    type:
      - 'null'
      - File
    doc: File containing a list of new genome files.
    inputBinding:
      position: 101
      prefix: --new-genomes-list
  - id: num_coassembly_samples
    type:
      - 'null'
      - int
    doc: Number of samples to include in coassembly.
    inputBinding:
      position: 101
      prefix: --num-coassembly-samples
  - id: precluster_distances
    type:
      - 'null'
      - float
    doc: Preclustering distance threshold.
    inputBinding:
      position: 101
      prefix: --precluster-distances
  - id: precluster_size
    type:
      - 'null'
      - int
    doc: Preclustering size threshold.
    inputBinding:
      position: 101
      prefix: --precluster-size
  - id: prior_assemblies
    type:
      - 'null'
      - Directory
    doc: Directory containing prior assemblies.
    inputBinding:
      position: 101
      prefix: --prior-assemblies
  - id: prodigal_meta
    type:
      - 'null'
      - boolean
    doc: Use Prodigal for meta-genomic mode.
    inputBinding:
      position: 101
      prefix: --prodigal-meta
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress output messages.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: retries
    type:
      - 'null'
      - int
    doc: Number of retries for failed jobs.
    inputBinding:
      position: 101
      prefix: --retries
  - id: reverse
    type:
      - 'null'
      - type: array
        items: File
    doc: List of reverse read files.
    inputBinding:
      position: 101
      prefix: --reverse
  - id: reverse_list
    type:
      - 'null'
      - File
    doc: File containing a list of reverse read files.
    inputBinding:
      position: 101
      prefix: --reverse-list
  - id: run_aviary
    type:
      - 'null'
      - boolean
    doc: Run Aviary pipeline.
    inputBinding:
      position: 101
      prefix: --run-aviary
  - id: run_qc
    type:
      - 'null'
      - boolean
    doc: Run quality control checks.
    inputBinding:
      position: 101
      prefix: --run-qc
  - id: sample_query
    type:
      - 'null'
      - type: array
        items: File
    doc: List of query files for samples.
    inputBinding:
      position: 101
      prefix: --sample-query
  - id: sample_query_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing query files for samples.
    inputBinding:
      position: 101
      prefix: --sample-query-dir
  - id: sample_query_list
    type:
      - 'null'
      - File
    doc: File containing a list of query files for samples.
    inputBinding:
      position: 101
      prefix: --sample-query-list
  - id: sample_read_size
    type:
      - 'null'
      - int
    doc: Read size for sample analysis.
    inputBinding:
      position: 101
      prefix: --sample-read-size
  - id: sample_singlem
    type:
      - 'null'
      - type: array
        items: File
    doc: List of singlem files for samples.
    inputBinding:
      position: 101
      prefix: --sample-singlem
  - id: sample_singlem_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing singlem files for samples.
    inputBinding:
      position: 101
      prefix: --sample-singlem-dir
  - id: sample_singlem_list
    type:
      - 'null'
      - File
    doc: File containing a list of singlem files for samples.
    inputBinding:
      position: 101
      prefix: --sample-singlem-list
  - id: single_assembly
    type:
      - 'null'
      - boolean
    doc: Perform a single assembly.
    inputBinding:
      position: 101
      prefix: --single-assembly
  - id: singlem_metapackage
    type:
      - 'null'
      - File
    doc: Metapackage file for singlem analysis.
    inputBinding:
      position: 101
      prefix: --singlem-metapackage
  - id: snakemake_args
    type:
      - 'null'
      - string
    doc: Additional arguments for Snakemake.
    inputBinding:
      position: 101
      prefix: --snakemake-args
  - id: snakemake_profile
    type:
      - 'null'
      - File
    doc: Snakemake profile to use.
    inputBinding:
      position: 101
      prefix: --snakemake-profile
  - id: sra
    type:
      - 'null'
      - boolean
    doc: Process SRA data.
    inputBinding:
      position: 101
      prefix: --sra
  - id: taxa_of_interest
    type:
      - 'null'
      - string
    doc: Taxonomic groups of interest.
    inputBinding:
      position: 101
      prefix: --taxa-of-interest
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory for intermediate files.
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: unmapping_max_alignment
    type:
      - 'null'
      - float
    doc: Maximum alignment for unmapping.
    inputBinding:
      position: 101
      prefix: --unmapping-max-alignment
  - id: unmapping_max_identity
    type:
      - 'null'
      - float
    doc: Maximum identity for unmapping.
    inputBinding:
      position: 101
      prefix: --unmapping-max-identity
  - id: unmapping_min_appraised
    type:
      - 'null'
      - float
    doc: Minimum appraised value for unmapping.
    inputBinding:
      position: 101
      prefix: --unmapping-min-appraised
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binchicken:0.13.5--pyhdfd78af_0
