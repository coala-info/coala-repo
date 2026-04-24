cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-dl
label: fastq-dl
doc: "Download FASTQ files from ENA or SRA.\n\nTool homepage: https://github.com/rpetit3/fastq-dl"
inputs:
  - id: accession
    type: string
    doc: ENA/SRA accession to query. (Study, Sample, Experiment, Run accession)
    inputBinding:
      position: 101
      prefix: --accession
  - id: cpus
    type:
      - 'null'
      - int
    doc: Total cpus used for downloading from SRA.
    inputBinding:
      position: 101
      prefix: --cpus
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files.
    inputBinding:
      position: 101
      prefix: --force
  - id: group_by_experiment
    type:
      - 'null'
      - boolean
    doc: Group Runs by experiment accession.
    inputBinding:
      position: 101
      prefix: --group-by-experiment
  - id: group_by_sample
    type:
      - 'null'
      - boolean
    doc: Group Runs by sample accession.
    inputBinding:
      position: 101
      prefix: --group-by-sample
  - id: ignore_checksums
    type:
      - 'null'
      - boolean
    doc: Ignore MD5 checksums for downloaded files.
    inputBinding:
      position: 101
      prefix: --ignore
  - id: max_attempts
    type:
      - 'null'
      - int
    doc: Maximum number of download attempts.
    inputBinding:
      position: 101
      prefix: --max-attempts
  - id: only_download_metadata
    type:
      - 'null'
      - boolean
    doc: Skip FASTQ downloads, and retrieve only the metadata.
    inputBinding:
      position: 101
      prefix: --only-download-metadata
  - id: only_provider
    type:
      - 'null'
      - boolean
    doc: Only attempt download from specified provider.
    inputBinding:
      position: 101
      prefix: --only-provider
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to output downloads to.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to use for naming log files.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: provider
    type:
      - 'null'
      - string
    doc: Specify which provider (ENA or SRA) to use.
    inputBinding:
      position: 101
      prefix: --provider
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Only critical errors will be printed.
    inputBinding:
      position: 101
      prefix: --silent
  - id: sleep
    type:
      - 'null'
      - int
    doc: Minimum amount of time to sleep between retries (API query and 
      download)
    inputBinding:
      position: 101
      prefix: --sleep
  - id: sra_lite
    type:
      - 'null'
      - boolean
    doc: Set preference to SRA Lite
    inputBinding:
      position: 101
      prefix: --sra-lite
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print debug related text.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-dl:3.0.1--pyhdfd78af_0
stdout: fastq-dl.out
