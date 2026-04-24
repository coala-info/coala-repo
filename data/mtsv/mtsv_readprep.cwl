cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtsv readprep
label: mtsv_readprep
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
  - id: config
    type:
      - 'null'
      - File
    doc: Specify path to config file path, relative to working directory, not 
      required if using default config.
    inputBinding:
      position: 102
      prefix: --config
  - id: fasta
    type:
      - 'null'
      - File
    doc: Path to FASTA query file produced by readprep. Avoid moving or renaming
      this file after it is made, required metadata is stored with this file.
    inputBinding:
      position: 102
      prefix: --fasta
  - id: kmer
    type:
      - 'null'
      - int
    doc: Set size of each read segment for segment trim mode.
    inputBinding:
      position: 102
      prefix: --kmer
  - id: log_file
    type:
      - 'null'
      - File
    doc: Set log file path, absolute or relative to working dir.
    inputBinding:
      position: 102
      prefix: --log_file
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of worker threads to spawn.
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
    inputBinding:
      position: 102
      prefix: --trim_mode
  - id: working_dir
    type:
      - 'null'
      - Directory
    doc: Specify working directory to place output.
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
stdout: mtsv_readprep.out
