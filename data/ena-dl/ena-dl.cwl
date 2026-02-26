cwlVersion: v1.2
class: CommandLineTool
baseCommand: ena-dl
label: ena-dl
doc: "Download FASTQs from ENA\n\nTool homepage: https://github.com/rpetit3/ena-dl"
inputs:
  - id: accession
    type: string
    doc: ENA accession to query. (Study, Experiment, or Run accession)
    inputBinding:
      position: 1
  - id: aspera
    type:
      - 'null'
      - string
    doc: Path to the Aspera Connect tool "ascp"
    inputBinding:
      position: 102
      prefix: --aspera
  - id: aspera_key
    type:
      - 'null'
      - string
    doc: Path to Aspera Connect private key, if not given, guess based on ascp 
      path
    inputBinding:
      position: 102
      prefix: --aspera_key
  - id: aspera_speed
    type:
      - 'null'
      - string
    doc: Speed at which Aspera Connect will download.
    default: 100M
    inputBinding:
      position: 102
      prefix: --aspera_speed
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Skip downloads, print what will be downloaded.
    inputBinding:
      position: 102
      prefix: --debug
  - id: ftp_only
    type:
      - 'null'
      - boolean
    doc: FTP only downloads.
    inputBinding:
      position: 102
      prefix: --ftp_only
  - id: group_by_experiment
    type:
      - 'null'
      - boolean
    doc: Group Runs by experiment accession.
    inputBinding:
      position: 102
      prefix: --group_by_experiment
  - id: group_by_sample
    type:
      - 'null'
      - boolean
    doc: Group Runs by sample accession.
    inputBinding:
      position: 102
      prefix: --group_by_sample
  - id: is_experiment
    type:
      - 'null'
      - boolean
    doc: Query is an Experiment.
    inputBinding:
      position: 102
      prefix: --is_experiment
  - id: is_run
    type:
      - 'null'
      - boolean
    doc: Query is a Run.
    inputBinding:
      position: 102
      prefix: --is_run
  - id: is_study
    type:
      - 'null'
      - boolean
    doc: Query is a Study.
    inputBinding:
      position: 102
      prefix: --is_study
  - id: max_retry
    type:
      - 'null'
      - int
    doc: Maximum times to retry downloads
    default: 10
    inputBinding:
      position: 102
      prefix: --max_retry
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to output downloads to.
    default: ./
    inputBinding:
      position: 102
      prefix: --outdir
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Only critical errors will be printed.
    inputBinding:
      position: 102
      prefix: --silent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ena-dl:1.0.0--1
stdout: ena-dl.out
