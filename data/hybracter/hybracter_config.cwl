cwlVersion: v1.2
class: CommandLineTool
baseCommand: hybracter_config
label: hybracter_config
doc: "Copy the system default config file\n\nTool homepage: https://github.com/gbouras13/hybracter"
inputs:
  - id: snake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for Snakemake
    inputBinding:
      position: 1
  - id: auto
    type:
      - 'null'
      - boolean
    doc: Automatically estimate the chromosome size using KMC.
    inputBinding:
      position: 102
      prefix: --auto
  - id: conda_prefix
    type:
      - 'null'
      - Directory
    doc: Custom conda env directory
    inputBinding:
      position: 102
      prefix: --conda-prefix
  - id: contaminants
    type:
      - 'null'
      - File
    doc: Contaminants FASTA file to map long readsagainst to filter out. Choose 
      --contaminants lambda to filter out phage lambda long reads.
    inputBinding:
      position: 102
      prefix: --contaminants
  - id: custom_config_file
    type:
      - 'null'
      - string
    doc: Custom config file
    inputBinding:
      position: 102
      prefix: --configfile
  - id: databases
    type:
      - 'null'
      - Directory
    doc: Plassembler Databases directory.
    inputBinding:
      position: 102
      prefix: --databases
  - id: depth_filter
    type:
      - 'null'
      - float
    doc: Depth filter to pass to Plassembler. Filters out all putative plasmid 
      contigs below this fraction of the chromosome read depth (needs to be 
      below in both long and short read sets for hybrid).
    inputBinding:
      position: 102
      prefix: --depth_filter
  - id: dnaapler_custom_db
    type:
      - 'null'
      - File
    doc: Custom amino acid FASTA file of sequences to be used as a database with
      dnaapler custom.
    inputBinding:
      position: 102
      prefix: --dnaapler_custom_db
  - id: extra_params_flye
    type:
      - 'null'
      - string
    doc: Use this if want to add extra parameters to Flye.
    inputBinding:
      position: 102
      prefix: --extra_params_flye
  - id: flye_model
    type:
      - 'null'
      - string
    doc: Flye Assembly Parameter
    inputBinding:
      position: 102
      prefix: --flyeModel
  - id: mac
    type:
      - 'null'
      - boolean
    doc: If you are running Hybracter on Mac - installs v1.8.0 of Medaka as 
      higher versions break.
    inputBinding:
      position: 102
      prefix: --mac
  - id: medaka_model
    type:
      - 'null'
      - string
    doc: Medaka Model.
    inputBinding:
      position: 102
      prefix: --medakaModel
  - id: medaka_override
    type:
      - 'null'
      - boolean
    doc: Use this if you do NOT want to use the --bacteria option with Medaka. 
      Instead your specified --medakaModel will be used.
    inputBinding:
      position: 102
      prefix: --medaka_override
  - id: min_depth
    type:
      - 'null'
      - int
    doc: minimum long read depth to continue the run. By default is 0x. 
      Hybracter will error and exit if a sample has less than 
      min_depth*chromosome_size bases of long-reads left AFTER filtlong and 
      porechop-ABI steps are run.
    inputBinding:
      position: 102
      prefix: --min_depth
  - id: min_length
    type:
      - 'null'
      - int
    doc: min read length for long reads
    inputBinding:
      position: 102
      prefix: --min_length
  - id: min_quality
    type:
      - 'null'
      - int
    doc: min read quality score for long reads in bp.
    inputBinding:
      position: 102
      prefix: --min_quality
  - id: no_medaka
    type:
      - 'null'
      - boolean
    doc: Do not polish the long read assembly with Medaka.
    inputBinding:
      position: 102
      prefix: --no_medaka
  - id: no_use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    inputBinding:
      position: 102
      prefix: --no-use-conda
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 102
      prefix: --output
  - id: skip_qc
    type:
      - 'null'
      - boolean
    doc: Do not run porechop_abi, filtlong and fastp to QC the reads
    inputBinding:
      position: 102
      prefix: --skip_qc
  - id: snake_default
    type:
      - 'null'
      - string
    doc: Customise Snakemake runtime args
      --conda-frontend conda
    inputBinding:
      position: 102
      prefix: --snake-default
  - id: subsample_depth
    type:
      - 'null'
      - int
    doc: subsampled long read depth to subsample with Filtlong. By default is 
      100x.
    inputBinding:
      position: 102
      prefix: --subsample_depth
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    inputBinding:
      position: 102
      prefix: --use-conda
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybracter:0.12.0--pyhdfd78af_0
stdout: hybracter_config.out
