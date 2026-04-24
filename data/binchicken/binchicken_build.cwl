cwlVersion: v1.2
class: CommandLineTool
baseCommand: binchen_build
label: binchicken_build
doc: "Create dependency environments\n\nTool homepage: https://github.com/aroneys/binchicken"
inputs:
  - id: build_gpu
    type:
      - 'null'
      - boolean
    doc: 'Build GPU-friendly environments for certain binners in Aviary recovery [default:
      do not]. Must be run on a node with GPU access.'
    inputBinding:
      position: 101
      prefix: --build-gpu
  - id: checkm2_db
    type:
      - 'null'
      - string
    doc: CheckM2 database
    inputBinding:
      position: 101
      prefix: --checkm2-db
  - id: cores
    type:
      - 'null'
      - int
    doc: Maximum number of cores to use
    inputBinding:
      position: 101
      prefix: --cores
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: download_databases
    type:
      - 'null'
      - boolean
    doc: Download databases if provided paths do not exist
    inputBinding:
      position: 101
      prefix: --download-databases
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: dry run workflow
    inputBinding:
      position: 101
      prefix: --dryrun
  - id: full_help
    type:
      - 'null'
      - boolean
    doc: print longer help message
    inputBinding:
      position: 101
      prefix: --full-help
  - id: full_help_roff
    type:
      - 'null'
      - boolean
    doc: print longer help message in ROFF (manpage) format
    inputBinding:
      position: 101
      prefix: --full-help-roff
  - id: gtdbtk_db
    type:
      - 'null'
      - string
    doc: GTDBtk release database (Only required if --aviary- speed is set to 
      {COMPREHENSIVE_AVIARY_MODE})
    inputBinding:
      position: 101
      prefix: --gtdbtk-db
  - id: local_cores
    type:
      - 'null'
      - int
    doc: Maximum number of cores to use on localrules when running in cluster 
      mode
    inputBinding:
      position: 101
      prefix: --local-cores
  - id: metabuli_db
    type:
      - 'null'
      - string
    doc: MetaBuli database (Only required with TaxVAMB extra binner)
    inputBinding:
      position: 101
      prefix: --metabuli-db
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --output
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: retries
    type:
      - 'null'
      - int
    doc: Number of times to retry a failed job
    inputBinding:
      position: 101
      prefix: --retries
  - id: set_tmp_dir
    type:
      - 'null'
      - string
    doc: Set temporary directory
    inputBinding:
      position: 101
      prefix: --set-tmp-dir
  - id: singlem_metapackage
    type:
      - 'null'
      - string
    doc: SingleM metapackage
    inputBinding:
      position: 101
      prefix: --singlem-metapackage
  - id: skip_aviary_envs
    type:
      - 'null'
      - boolean
    doc: Do not install Aviary subworkflow environments
    inputBinding:
      position: 101
      prefix: --skip-aviary-envs
  - id: snakemake_args
    type:
      - 'null'
      - string
    doc: Additional commands to be supplied to snakemake in the form of a 
      space-prefixed single string e.g. " --quiet"
    inputBinding:
      position: 101
      prefix: --snakemake-args
  - id: snakemake_profile
    type:
      - 'null'
      - string
    doc: Snakemake profile (see 
      https://snakemake.readthedocs.io/en/v7.32.3/executing/cli.html#profiles). 
      Can be used to submit rules as jobs to cluster engine (see 
      https://snakemake.readthedocs.io/en/v7.32.3/executing/cluster.html).
    inputBinding:
      position: 101
      prefix: --snakemake-profile
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Path to temporary directory.
    inputBinding:
      position: 101
      prefix: --tmp-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binchicken:0.13.5--pyhdfd78af_0
stdout: binchicken_build.out
