cwlVersion: v1.2
class: CommandLineTool
baseCommand: binchicken update
label: binchicken_update
doc: "Update binchicken's databases and configurations.\n\nTool homepage: https://github.com/aroneys/binchicken"
inputs:
  - id: anchor_samples
    type:
      - 'null'
      - type: array
        items: string
    doc: List of sample names to use as anchors for coassembly.
    inputBinding:
      position: 101
      prefix: --anchor-samples
  - id: anchor_samples_list
    type:
      - 'null'
      - File
    doc: File containing a list of sample names to use as anchors for 
      coassembly.
    inputBinding:
      position: 101
      prefix: --anchor-samples-list
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
    doc: Memory limit for Aviary assembly.
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
    doc: Memory limit for Aviary recovery.
    inputBinding:
      position: 101
      prefix: --aviary-recover-memory
  - id: aviary_request_gpu
    type:
      - 'null'
      - boolean
    doc: Request GPU for Aviary jobs.
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
    default: fast
    inputBinding:
      position: 101
      prefix: --aviary-speed
  - id: cluster_submission
    type:
      - 'null'
      - boolean
    doc: Enable cluster submission for jobs.
    inputBinding:
      position: 101
      prefix: --cluster-submission
  - id: coassemblies_list
    type:
      - 'null'
      - File
    doc: File containing a list of directories with coassembly results.
    inputBinding:
      position: 101
      prefix: --coassemblies-list
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
    doc: Limit on the number of samples to download.
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
  - id: genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: List of reference genomes.
    inputBinding:
      position: 101
      prefix: --genomes
  - id: genomes_list
    type:
      - 'null'
      - File
    doc: File containing a list of reference genomes.
    inputBinding:
      position: 101
      prefix: --genomes-list
  - id: local_cores
    type:
      - 'null'
      - int
    doc: Number of local cores to use for Snakemake.
    inputBinding:
      position: 101
      prefix: --local-cores
  - id: prior_assemblies
    type:
      - 'null'
      - Directory
    doc: Directory containing prior assemblies.
    inputBinding:
      position: 101
      prefix: --prior-assemblies
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
    doc: Run Aviary for binning.
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
  - id: snakemake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments to pass to Snakemake.
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
    doc: Indicates that samples are from SRA.
    inputBinding:
      position: 101
      prefix: --sra
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
      - int
    doc: Maximum alignment length for unmapping.
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
  - id: coassemble_output
    type:
      - 'null'
      - Directory
    doc: Output directory for coassembly results.
    outputBinding:
      glob: $(inputs.coassemble_output)
  - id: coassemble_unbinned
    type:
      - 'null'
      - Directory
    doc: Directory to store unbinned contigs from coassembly.
    outputBinding:
      glob: $(inputs.coassemble_unbinned)
  - id: coassemble_binned
    type:
      - 'null'
      - Directory
    doc: Directory to store binned contigs from coassembly.
    outputBinding:
      glob: $(inputs.coassemble_binned)
  - id: coassemble_targets
    type:
      - 'null'
      - File
    doc: File to store target sequences from coassembly.
    outputBinding:
      glob: $(inputs.coassemble_targets)
  - id: coassemble_elusive_edges
    type:
      - 'null'
      - File
    doc: File to store elusive edges from coassembly.
    outputBinding:
      glob: $(inputs.coassemble_elusive_edges)
  - id: coassemble_elusive_clusters
    type:
      - 'null'
      - File
    doc: File to store elusive clusters from coassembly.
    outputBinding:
      glob: $(inputs.coassemble_elusive_clusters)
  - id: coassemble_summary
    type:
      - 'null'
      - File
    doc: Summary file for coassembly results.
    outputBinding:
      glob: $(inputs.coassemble_summary)
  - id: coassemblies
    type:
      - 'null'
      - Directory
    doc: List of directories containing coassembly results.
    outputBinding:
      glob: $(inputs.coassemblies)
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory for results.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binchicken:0.13.5--pyhdfd78af_0
