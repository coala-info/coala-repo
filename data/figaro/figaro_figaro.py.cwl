cwlVersion: v1.2
class: CommandLineTool
baseCommand: figaro.py
label: figaro_figaro.py
doc: "Figaro: find the best trimming positions for paired-end amplicon reads before\
  \ denoising with DADA2 (picks the trim lengths that keep the most reads under an expected-error\
  \ limit).\n\nTool homepage: https://github.com/Zymo-Research/figaro"
inputs:
  - id: amplicon_length
    type: int
    doc: Length of amplicon (not including primers)
    inputBinding:
      position: 101
      prefix: --ampliconLength
  - id: forward_primer_length
    type: int
    doc: Length of forward primer
    inputBinding:
      position: 101
      prefix: --forwardPrimerLength
  - id: reverse_primer_length
    type: int
    doc: Length of reverse primer
    inputBinding:
      position: 101
      prefix: --reversePrimerLength
  - id: input_directory
    type:
      - 'null'
      - Directory
    doc: Directory with Fastq files to analyze
    inputBinding:
      position: 101
      prefix: --inputDirectory
  - id: output_directory
    type:
      - 'null'
      - string
    doc: Directory for outputs; it must already exist (the default is the working
      directory)
    inputBinding:
      position: 101
      prefix: --outputDirectory
  - id: output_file_name
    type:
      - 'null'
      - string
    default: trimParameters.json
    doc: Output file for trim site JSON
    inputBinding:
      position: 101
      prefix: --outputFileName
  - id: minimum_overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap between the paired-end reads
    inputBinding:
      position: 101
      prefix: --minimumOverlap
  - id: subsample
    type:
      - 'null'
      - int
    doc: Subsampling level (will analyze approximately 1/x reads)
    inputBinding:
      position: 101
      prefix: --subsample
  - id: percentile
    type:
      - 'null'
      - int
    doc: Percentile to use for expected error model
    inputBinding:
      position: 101
      prefix: --percentile
  - id: file_naming_standard
    type:
      - 'null'
      - string
    doc: File naming standard to use
    inputBinding:
      position: 101
      prefix: --fileNamingStandard
  - id: log_file
    type:
      - 'null'
      - string
    doc: Log file path
    inputBinding:
      position: 101
      prefix: --logFile
outputs:
  - id: trim_parameters
    type: File
    doc: JSON file with the suggested trim positions
    outputBinding:
      glob: $(inputs.output_file_name)
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: '*.log'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/figaro:1.1.2--hdfd78af_0
