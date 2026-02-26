cwlVersion: v1.2
class: CommandLineTool
baseCommand: humanfilt run
label: humanfilt_run
doc: "Run humanfilt\n\nTool homepage: https://github.com/jprehn-lab/humanfilt"
inputs:
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing humanfilt data
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: input
    type: File
    doc: Input file
    inputBinding:
      position: 101
      prefix: --input
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Keep per-sample temp dirs for debugging
    inputBinding:
      position: 101
      prefix: --keep-temp
  - id: kraken2_db
    type:
      - 'null'
      - Directory
    doc: Path to Kraken2 database
    inputBinding:
      position: 101
      prefix: --kraken2-db
  - id: mode
    type: string
    doc: Mode of operation (wgs or rna-seq)
    inputBinding:
      position: 101
      prefix: --mode
  - id: no_auto_setup
    type:
      - 'null'
      - boolean
    doc: Disable automatic setup
    inputBinding:
      position: 101
      prefix: --no-auto-setup
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: trim_length
    type:
      - 'null'
      - int
    doc: Minimum length after trimming
    inputBinding:
      position: 101
      prefix: --trim-length
  - id: trim_quality
    type:
      - 'null'
      - int
    doc: Minimum quality score for trimming
    inputBinding:
      position: 101
      prefix: --trim-quality
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: $(inputs.output)
  - id: report
    type: File
    doc: Report file
    outputBinding:
      glob: $(inputs.report)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humanfilt:1.0.0--pyhdfd78af_0
