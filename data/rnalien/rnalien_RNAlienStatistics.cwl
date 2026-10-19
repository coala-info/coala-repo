cwlVersion: v1.2
class: CommandLineTool
baseCommand: RNAlienStatistics
label: rnalien_RNAlienStatistics
doc: "RNAlienStatistics compares an RNAlien covariance model with an Rfam covariance model (cross-searches the family fasta files and reports bit scores, optionally link scores).\n\nTool homepage: https://github.com/eggzilla/RNAlien"
inputs:
  - id: alien_covariance_model_path
    type:
      - 'null'
      - File
    doc: Path to alienCovarianceModelPath
    inputBinding:
      position: 101
      prefix: -i
  - id: alien_rnaz_path
    type:
      - 'null'
      - File
    doc: Path to alienRNAzResult
    inputBinding:
      position: 101
      prefix: -z
  - id: alien_rnacode_path
    type:
      - 'null'
      - File
    doc: Path to alienRNAcodeResult
    inputBinding:
      position: 101
      prefix: -w
  - id: alien_cmstat_path
    type:
      - 'null'
      - File
    doc: Path to aliencmstatResult
    inputBinding:
      position: 101
      prefix: -m
  - id: rfam_covariance_model_path
    type:
      - 'null'
      - File
    doc: Path to rfamCovarianceModelPath
    inputBinding:
      position: 101
      prefix: -r
  - id: rfam_fasta_file_path
    type:
      - 'null'
      - File
    doc: Path to rfamFastaFile
    inputBinding:
      position: 101
      prefix: -g
  - id: alien_fasta_file_path
    type:
      - 'null'
      - File
    doc: Path to alienFastaFile
    inputBinding:
      position: 101
      prefix: -a
  - id: rfam_model_name
    type:
      - 'null'
      - string
    doc: Rfam model name
    inputBinding:
      position: 101
      prefix: -n
  - id: rfam_model_id
    type:
      - 'null'
      - string
    doc: Rfam model id
    inputBinding:
      position: 101
      prefix: -d
  - id: rfam_threshold
    type:
      - 'null'
      - float
    doc: Bitscore threshold for Rfam model hits on Alien fasta, default 20
    inputBinding:
      position: 101
      prefix: -x
  - id: alien_threshold
    type:
      - 'null'
      - float
    doc: Bitscore threshold for RNAlien model hits on Rfam fasta, default 20
    inputBinding:
      position: 101
      prefix: -t
  - id: database_size
    type:
      - 'null'
      - float
    doc: Cmsearch database size in mega bases. default not set
    inputBinding:
      position: 101
      prefix: -k
  - id: output_directory_path
    type:
      - 'null'
      - string
    doc: Path to output directory
    inputBinding:
      position: 101
      prefix: -o
  - id: benchmark_index
    type:
      - 'null'
      - int
    doc: Index used to identify sRNA tagged RNA families
    inputBinding:
      position: 101
      prefix: -b
  - id: threshold_selection
    type:
      - 'null'
      - string
    doc: Selection method, (bitscore, evalue), default bitscore
    inputBinding:
      position: 101
      prefix: -s
  - id: link_scores
    type:
      - 'null'
      - boolean
    doc: Triggers computation of linkscores via CMCompare
    inputBinding:
      position: 101
      prefix: -l
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of available cpu slots/cores, default 1
    inputBinding:
      position: 101
      prefix: -c
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Loud verbosity
    inputBinding:
      position: 101
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet verbosity
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$(inputs.output_directory_path ? {class: "Directory", basename: inputs.output_directory_path, listing: []} : null)'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnalien:1.8.0--1
stdout: rnalien_RNAlienStatistics.out
