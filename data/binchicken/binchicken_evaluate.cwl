cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - binchicken
  - evaluate
label: binchicken_evaluate
doc: "Evaluate coassembled bins\n\nTool homepage: https://github.com/aroneys/binchicken"
inputs:
  - id: coassemble_output
    type:
      - 'null'
      - Directory
    doc: Output dir from coassemble subcommand
    inputBinding:
      position: 101
      prefix: --coassemble-output
  - id: coassemble_unbinned
    type:
      - 'null'
      - File
    doc: SingleM appraise unbinned output from Bin Chicken coassemble 
      (alternative to --coassemble-output)
    inputBinding:
      position: 101
      prefix: --coassemble-unbinned
  - id: coassemble_binned
    type:
      - 'null'
      - File
    doc: SingleM appraise binned output from Bin Chicken coassemble (alternative
      to --coassemble-output)
    inputBinding:
      position: 101
      prefix: --coassemble-binned
  - id: coassemble_targets
    type:
      - 'null'
      - File
    doc: Target sequences output from Bin Chicken coassemble (alternative to 
      --coassemble-output)
    inputBinding:
      position: 101
      prefix: --coassemble-targets
  - id: coassemble_elusive_edges
    type:
      - 'null'
      - File
    doc: Elusive edges output from Bin Chicken coassemble (alternative to 
      --coassemble-output)
    inputBinding:
      position: 101
      prefix: --coassemble-elusive-edges
  - id: coassemble_elusive_clusters
    type:
      - 'null'
      - File
    doc: Elusive clusters output from Bin Chicken coassemble (alternative to 
      --coassemble-output)
    inputBinding:
      position: 101
      prefix: --coassemble-elusive-clusters
  - id: coassemble_summary
    type:
      - 'null'
      - File
    doc: Summary output from Bin Chicken coassemble (alternative to 
      --coassemble-output)
    inputBinding:
      position: 101
      prefix: --coassemble-summary
  - id: aviary_outputs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Output dir from Aviary coassembly and recover commands produced by 
      coassemble subcommand
    inputBinding:
      position: 101
      prefix: --aviary-outputs
  - id: new_genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: New genomes to evaluate (alternative to --aviary-outputs, also 
      requires --coassembly-run)
    inputBinding:
      position: 101
      prefix: --new-genomes
  - id: new_genomes_list
    type:
      - 'null'
      - File
    doc: New genomes to evaluate (alternative to --aviary-outputs, also 
      requires --coassembly-run) newline separated
    inputBinding:
      position: 101
      prefix: --new-genomes-list
  - id: coassembly_run
    type:
      - 'null'
      - string
    doc: Name of coassembly run to produce new genomes (alternative to 
      --aviary-outputs, also requires --new-genomes)
    inputBinding:
      position: 101
      prefix: --coassembly-run
  - id: singlem_metapackage
    type:
      - 'null'
      - Directory
    doc: SingleM metapackage for sequence searching
    inputBinding:
      position: 101
      prefix: --singlem-metapackage
  - id: prodigal_meta
    type:
      - 'null'
      - boolean
    doc: Use prodigal "-p meta" argument (for testing)
    inputBinding:
      position: 101
      prefix: --prodigal-meta
  - id: checkm_version
    type:
      - 'null'
      - int
    doc: 'CheckM version to use to quality cutoffs [default: 2]'
    inputBinding:
      position: 101
      prefix: --checkm-version
  - id: min_completeness
    type:
      - 'null'
      - float
    doc: 'Include bins with at least this minimum completeness [default: 70]'
    inputBinding:
      position: 101
      prefix: --min-completeness
  - id: max_contamination
    type:
      - 'null'
      - float
    doc: 'Include bins with at most this maximum contamination [default: 10]'
    inputBinding:
      position: 101
      prefix: --max-contamination
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: Cluster new and original genomes and report number of new clusters
    inputBinding:
      position: 101
      prefix: --cluster
  - id: cluster_ani
    type:
      - 'null'
      - float
    doc: 'Cluster using this sequence identity [default: 86%]'
    inputBinding:
      position: 101
      prefix: --cluster-ani
  - id: genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: Original genomes used as references for coassemble subcommand
    inputBinding:
      position: 101
      prefix: --genomes
  - id: genomes_list
    type:
      - 'null'
      - File
    doc: Original genomes used as references for coassemble subcommand newline
      separated
    inputBinding:
      position: 101
      prefix: --genomes-list
  - id: output
    type: string
    doc: 'Output directory [default: .]'
    default: binchicken_evaluate
    inputBinding:
      position: 101
      prefix: --output
  - id: cores
    type:
      - 'null'
      - int
    doc: 'Maximum number of cores to use [default: 1]'
    inputBinding:
      position: 101
      prefix: --cores
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: dry run workflow
    inputBinding:
      position: 101
      prefix: --dryrun
  - id: snakemake_profile
    type:
      - 'null'
      - string
    doc: Snakemake profile. Can be used to submit rules as jobs to cluster 
      engine.
    inputBinding:
      position: 101
      prefix: --snakemake-profile
  - id: local_cores
    type:
      - 'null'
      - int
    doc: 'Maximum number of cores to use on localrules when running in cluster 
      mode [default: 1]'
    inputBinding:
      position: 101
      prefix: --local-cores
  - id: retries
    type:
      - 'null'
      - int
    doc: 'Number of times to retry a failed job [default: 3].'
    inputBinding:
      position: 101
      prefix: --retries
  - id: snakemake_args
    type:
      - 'null'
      - string
    doc: Additional commands to be supplied to snakemake in the form of a 
      space-prefixed single string e.g. " --quiet"
    inputBinding:
      position: 101
      prefix: --snakemake-args
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: 'Path to temporary directory. [default: no default]'
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the evaluation results.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binchicken:0.13.5--pyhdfd78af_0
