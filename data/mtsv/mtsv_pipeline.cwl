cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtsv_pipeline
label: mtsv_pipeline
doc: "Additional Snakemake commands may also be provided\n\nTool homepage: https://github.com/FofanovLab/MTSv"
inputs:
  - id: fastq
    type:
      type: array
      items: File
    doc: Path(s) to FASTQ files to deduplicate, absolute path or relative to 
      working dir.
    inputBinding:
      position: 1
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
      position: 102
      prefix: --binning_mode
  - id: binning_outpath
    type:
      - 'null'
      - Directory
    doc: Path to write binning files to.
    default: ./Binning/
    inputBinding:
      position: 102
      prefix: --binning_outpath
  - id: config
    type:
      - 'null'
      - File
    doc: Specify path to config file path, relative to working directory, not 
      required if using default config.
    inputBinding:
      position: 102
      prefix: --config
  - id: database_config
    type:
      - 'null'
      - File
    doc: Path to sequence database configuration json.
    inputBinding:
      position: 102
      prefix: --database_config
  - id: edits
    type:
      - 'null'
      - int
    doc: Edit distance to tolerate in matched reference sites
    default: 3
    inputBinding:
      position: 102
      prefix: --edits
  - id: fasta
    type:
      - 'null'
      - File
    doc: Path to FASTA query file produced by readprep. Avoid moving or renaming
      this file after it is made, required metadata is stored with this file.
    default: ./QueryFastas/queries.fasta
    inputBinding:
      position: 102
      prefix: --fasta
  - id: kmer
    type:
      - 'null'
      - int
    doc: Set size of each read segment for segment trim mode.
    default: 50
    inputBinding:
      position: 102
      prefix: --kmer
  - id: log_file
    type:
      - 'null'
      - File
    doc: Set log file path, absolute or relative to working dir.
    default: ./Logs/mtsv_{COMMAND}_{TIMESTAMP}.log
    inputBinding:
      position: 102
      prefix: --log_file
  - id: merge_file
    type:
      - 'null'
      - File
    doc: Merged binning output file. (WARNING avoid moving output files from 
      their original directory, downstream processes rely on meta data (.params 
      file) in directory)
    default: ./Binning/merged.clp
    inputBinding:
      position: 102
      prefix: --merge_file
  - id: min_seeds
    type:
      - 'null'
      - int
    doc: Minimum number of seeds to perform alignment of a candidate site. 
      Overrides binning mode setting.
    inputBinding:
      position: 102
      prefix: --min_seeds
  - id: seed_gap
    type:
      - 'null'
      - int
    doc: Gap between seeds used for initial exact match. Overrides binning mode 
      setting.
    inputBinding:
      position: 102
      prefix: --seed_gap
  - id: seed_size
    type:
      - 'null'
      - int
    doc: Exact match query size. Overrides binning mode setting.
    inputBinding:
      position: 102
      prefix: --seed_size
  - id: signature_file
    type:
      - 'null'
      - File
    doc: File to place signature hits output.
    default: ./Summary/signature.txt
    inputBinding:
      position: 102
      prefix: --signature_file
  - id: summary_file
    type:
      - 'null'
      - File
    doc: File to place summary table. WARNING avoid moving output files from 
      original directory, downstream processes rely on metadata (.params file) 
      stored in directory.
    default: ./Summary/summary.csv
    inputBinding:
      position: 102
      prefix: --summary_file
  - id: tax_level
    type:
      - 'null'
      - string
    doc: Roll up read hits to a common genus or family level when searching for 
      signature hits. (Takes priority over LCA search when family or genus exist
      for a taxonomic ID.) More roll up options comming soon. Choices are 
      ['family', 'genus', 'species']
    default: species
    inputBinding:
      position: 102
      prefix: --tax_level
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of worker threads to spawn.
    default: 4
    inputBinding:
      position: 102
      prefix: --threads
  - id: trim_mode
    type:
      - 'null'
      - string
    doc: --lcd takes first N bases of each read, where N = shortest read length 
      in FASTQ --segment takes subsequent N length sequences of each read (set N
      with --kmer) Choices are ['lcd', 'segment']
    default: segment
    inputBinding:
      position: 102
      prefix: --trim_mode
  - id: working_dir
    type:
      - 'null'
      - Directory
    doc: Specify working directory to place output.
    default: /
    inputBinding:
      position: 102
      prefix: --wd
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv:1.0.6--py36hf1ae8f4_2
stdout: mtsv_pipeline.out
