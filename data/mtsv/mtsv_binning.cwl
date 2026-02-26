cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtsv binning
label: mtsv_binning
doc: "Additional Snakemake commands may also be provided\n\nTool homepage: https://github.com/FofanovLab/MTSv"
inputs:
  - id: binning_mode
    type:
      - 'null'
      - string
    doc: Set recommended parameters for SEED_SIZE, MIN_SEEDS, SEED_GAP for fast 
      (more misses, fast runtime), efficient (med misses, med runtime) or 
      sensitive (few misses, slow) runs. fast=17,5,2, efficient=14,4,2, 
      sensitive=11,3,1. Passing values for the SEED_SIZE, MIN_SEEDS or SEED_GAP 
      parameters will override these settings. Choices are ['fast', 'efficient',
      'sensitive']
    default: efficient
    inputBinding:
      position: 101
      prefix: --binning_mode
  - id: config
    type:
      - 'null'
      - File
    doc: Specify path to config file path, relative to working directory, not 
      required if using default config.
    inputBinding:
      position: 101
      prefix: --config
  - id: database_config
    type:
      - 'null'
      - File
    doc: Path to sequence database configuration json.
    inputBinding:
      position: 101
      prefix: --database_config
  - id: edits
    type:
      - 'null'
      - int
    doc: Edit distance to tolerate in matched reference sites
    default: 3
    inputBinding:
      position: 101
      prefix: --edits
  - id: fasta
    type:
      - 'null'
      - File
    doc: Path to FASTA query file produced by readprep.
    default: ./QueryFastas/queries.fasta
    inputBinding:
      position: 101
      prefix: --fasta
  - id: log_file
    type:
      - 'null'
      - File
    doc: Set log file path, absolute or relative to working dir.
    default: ./Logs/mtsv_{COMMAND}_{TIMESTAMP}.log
    inputBinding:
      position: 101
      prefix: --log_file
  - id: min_seeds
    type:
      - 'null'
      - int
    doc: Minimum number of seeds to perform alignment of a candidate site. 
      Overrides binning mode setting.
    inputBinding:
      position: 101
      prefix: --min_seeds
  - id: seed_gap
    type:
      - 'null'
      - int
    doc: Gap between seeds used for initial exact match. Overrides binning mode 
      setting.
    inputBinding:
      position: 101
      prefix: --seed_gap
  - id: seed_size
    type:
      - 'null'
      - int
    doc: Exact match query size. Overrides binning mode setting.
    inputBinding:
      position: 101
      prefix: --seed_size
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of worker threads to spawn.
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: working_dir
    type:
      - 'null'
      - Directory
    doc: Specify working directory to place output.
    default: /
    inputBinding:
      position: 101
      prefix: --working_dir
outputs:
  - id: binning_outpath
    type:
      - 'null'
      - Directory
    doc: Path to write binning files to.
    outputBinding:
      glob: $(inputs.binning_outpath)
  - id: merge_file
    type:
      - 'null'
      - File
    doc: Merged binning output file. (WARNING avoid moving output files from 
      their original directory, downstream processes rely on meta data (.params 
      file) in directory)
    outputBinding:
      glob: $(inputs.merge_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv:1.0.6--py36hf1ae8f4_2
