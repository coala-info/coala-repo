cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtsv analyze
label: mtsv_analyze
doc: "Additional Snakemake commands may also be provided\n\nTool homepage: https://github.com/FofanovLab/MTSv"
inputs:
  - id: can_taxa_list
    type:
      - 'null'
      - File
    doc: "Provide a custom list of candidate taxa instead of\ncalculating candidates
      based SIGNATURE_CUTOFF of\nunique signature hits. Should be a file with taxids\n\
      listed in a single column."
    inputBinding:
      position: 101
      prefix: --can_taxa_list
  - id: config
    type:
      - 'null'
      - File
    doc: "Specify path to config file path, relative to working\ndirectory, not required
      if using default config."
    inputBinding:
      position: 101
      prefix: --config
  - id: log_file
    type:
      - 'null'
      - File
    doc: "Set log file path, absolute or relative to working\ndir."
    inputBinding:
      position: 101
      prefix: --log_file
  - id: n_kmers
    type:
      - 'null'
      - int
    doc: "Up to N_KMERS random kmers will be generated for each\nof the candidate
      taxa. These will be used to estimate\nexpected values."
    inputBinding:
      position: 101
      prefix: --n_kmers
  - id: signature_cutoff
    type:
      - 'null'
      - int
    doc: "Run analysis only for taxa with unique signature hits\nthat are greater
      than SIGNATURE_CUTOFF."
    inputBinding:
      position: 101
      prefix: --signature_cutoff
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of worker threads to spawn.
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_database
    type:
      - 'null'
      - boolean
    doc: "If (T)rue, use previously calculated expected values\nwhere available. If
      (F)alse, all expected values will\nbe recalculated and used to update the database."
    inputBinding:
      position: 101
      prefix: --use_database
  - id: working_dir
    type:
      - 'null'
      - Directory
    doc: Specify working directory to place output.
    inputBinding:
      position: 101
      prefix: --wd
outputs:
  - id: analysis_file
    type:
      - 'null'
      - File
    doc: File to write output.
    outputBinding:
      glob: $(inputs.analysis_file)
  - id: summary_file
    type:
      - 'null'
      - File
    doc: Path to summary output
    outputBinding:
      glob: $(inputs.summary_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv:1.0.6--py36hf1ae8f4_2
