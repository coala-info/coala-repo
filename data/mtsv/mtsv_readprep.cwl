cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mtsv
  - readprep
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
      prefix: --fastq
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
    type: string
    default: QueryFastas/queries.fasta
    doc: Path to FASTA query file produced by readprep, relative to the working directory. Avoid moving or renaming this file after it is made, required metadata is stored with this file.
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
      - string
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
    type: string
    default: .
    doc: Specify working directory to place output (the tool default is /tmp, so keep this at . to collect the results).
    inputBinding:
      position: 102
      prefix: --wd
outputs:
  - id: query_fasta
    type: File
    doc: Deduplicated query FASTA file (reads cut into segments)
    outputBinding:
      glob: $(inputs.fasta)
  - id: report
    type: ['null', File]
    doc: Readprep report
    outputBinding:
      glob: Reports/readprep_report.html
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv:1.0.6--py36hf1ae8f4_2
