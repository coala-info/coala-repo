cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mtsv
  - summary
label: mtsv_summary
doc: "Additional Snakemake commands may also be provided\n\nTool homepage: https://github.com/FofanovLab/MTSv"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Specify path to config file path, relative to working directory, not 
      required if using default config.
    inputBinding:
      position: 101
      prefix: --config
  - id: log_file
    type:
      - 'null'
      - File
    doc: Set log file path, absolute or relative to working dir.
    default: ./Logs/mtsv_{COMMAND}_{TIMESTAMP}.log
    inputBinding:
      position: 101
      prefix: --log_file
  - id: merge_file
    type:
      - 'null'
      - File
    doc: Merged binning output file.
    default: ./Binning/merged.clp
    inputBinding:
      position: 101
      prefix: --merge_file
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
      position: 101
      prefix: --tax_level
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
      prefix: --wd
outputs:
  - id: signature_file
    type:
      - 'null'
      - File
    doc: File to place signature hits output.
    outputBinding:
      glob: $(inputs.signature_file)
  - id: summary_file
    type:
      - 'null'
      - File
    doc: File to place summary table. WARNING avoid moving output files from 
      original directory, downstream processes rely on metadata (.params file) 
      stored in directory.
    outputBinding:
      glob: $(inputs.summary_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv:1.0.6--py36hf1ae8f4_2
