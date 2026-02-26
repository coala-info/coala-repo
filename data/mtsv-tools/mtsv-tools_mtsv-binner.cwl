cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtsv-binner
label: mtsv-tools_mtsv-binner
doc: "Metagenomic and metatranscriptomic assignment tool.\n\nTool homepage: https://github.com/FofanovLab/mtsv_tools"
inputs:
  - id: edit_rate
    type:
      - 'null'
      - float
    doc: The maximum proportion of edits allowed for alignment.
    default: 0.13
    inputBinding:
      position: 101
      prefix: --edit-rate
  - id: fasta
    type: File
    doc: Path to FASTA reads.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fastq
    type: File
    doc: Path to FASTQ reads.
    inputBinding:
      position: 101
      prefix: --fastq
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Always overwrite the results file instead of resuming from existing 
      output.
    inputBinding:
      position: 101
      prefix: --force-overwrite
  - id: index
    type: Directory
    doc: Path to MG-index file.
    inputBinding:
      position: 101
      prefix: --index
  - id: max_assignments
    type:
      - 'null'
      - int
    doc: Stop after this many successful assignments per read.
    inputBinding:
      position: 101
      prefix: --max-assignments
  - id: max_candidates
    type:
      - 'null'
      - int
    doc: Stop checking candidates after this many per read.
    inputBinding:
      position: 101
      prefix: --max-candidates
  - id: max_hits
    type:
      - 'null'
      - int
    doc: Skip seeds with more than MAX_HITS hits.
    default: 2000
    inputBinding:
      position: 101
      prefix: --max-hits
  - id: min_seed
    type:
      - 'null'
      - float
    doc: Set the minimum percentage of seeds required to perform an alignment.
    default: 0.015
    inputBinding:
      position: 101
      prefix: --min-seed
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output format: default (taxid=edit) or long (taxid-gi-offset=edit).'
    default: default
    inputBinding:
      position: 101
      prefix: --output-format
  - id: read_offset
    type:
      - 'null'
      - int
    doc: Skip this many reads before processing.
    default: 0
    inputBinding:
      position: 101
      prefix: --read-offset
  - id: seed_interval
    type:
      - 'null'
      - int
    doc: Set the interval between seeds used for initial exact match.
    default: 15
    inputBinding:
      position: 101
      prefix: --seed-interval
  - id: seed_size
    type:
      - 'null'
      - int
    doc: Set seed size.
    default: 18
    inputBinding:
      position: 101
      prefix: --seed-size
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of worker threads to spawn.
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: tune_max_hits
    type:
      - 'null'
      - int
    doc: Each time the number of seed hits is greater than TUNE_MAX_HITS but 
      less than MAX_HITS, the seed interval will be doubled to reduce the number
      of seed hits and reduce runtime.
    default: 200
    inputBinding:
      position: 101
      prefix: --tune-max-hits
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Include this flag to trigger debug-level logging.
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: results_path
    type:
      - 'null'
      - File
    doc: Path to write results file.
    outputBinding:
      glob: $(inputs.results_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv-tools:2.1.0--h54198d6_0
