cwlVersion: v1.2
class: CommandLineTool
baseCommand: circminer
label: circminer
doc: "CircRNA detection and analysis tool\n\nTool homepage: https://github.com/vpc-ccg/circminer"
inputs:
  - id: band_width
    type:
      - 'null'
      - int
    doc: Band width for banded alignment
    default: 3
    inputBinding:
      position: 101
      prefix: --band
  - id: compact_index
    type:
      - 'null'
      - boolean
    doc: Use this option only while building the index to enable compact version
      of the index.
    inputBinding:
      position: 101
      prefix: --compact-index
  - id: gtf
    type:
      - 'null'
      - File
    doc: Gene model file.
    inputBinding:
      position: 101
      prefix: --gtf
  - id: index_stage
    type:
      - 'null'
      - boolean
    doc: Indicates the indexing stage.
    inputBinding:
      position: 101
      prefix: --index
  - id: kmer
    type:
      - 'null'
      - int
    doc: Kmer size [14..22]
    default: 20
    inputBinding:
      position: 101
      prefix: --kmer
  - id: max_chain_list
    type:
      - 'null'
      - int
    doc: Maximum number of chained candidates to be processed
    default: 30
    inputBinding:
      position: 101
      prefix: --max-chain-list
  - id: max_edit_distance
    type:
      - 'null'
      - int
    doc: Max allowed edit distance on each mate
    default: 4
    inputBinding:
      position: 101
      prefix: --max-ed
  - id: max_intron_length
    type:
      - 'null'
      - int
    doc: Maximum length of an intron
    default: 2000000
    inputBinding:
      position: 101
      prefix: --max-intron
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: Max read length
    default: 300
    inputBinding:
      position: 101
      prefix: --rlen
  - id: max_soft_clipping
    type:
      - 'null'
      - int
    doc: Max allowed soft clipping on each mate
    default: 7
    inputBinding:
      position: 101
      prefix: --max-sc
  - id: max_template_length
    type:
      - 'null'
      - int
    doc: Maximum template length of concordant mapping. Paired-end mode only
    default: 500
    inputBinding:
      position: 101
      prefix: --max-tlen
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix of output files
    default: output
    inputBinding:
      position: 101
      prefix: --output
  - id: pam_output
    type:
      - 'null'
      - boolean
    doc: Enables custom pam output for aligned reads. Cannot be set along with 
      --sam.
    inputBinding:
      position: 101
      prefix: --pam
  - id: reference
    type: File
    doc: Reference file.
    inputBinding:
      position: 101
      prefix: --reference
  - id: sam_output
    type:
      - 'null'
      - boolean
    doc: Enables SAM output for aligned reads. Cannot be set along with --pam.
    inputBinding:
      position: 101
      prefix: --sam
  - id: scan_level
    type:
      - 'null'
      - int
    doc: 'Transcriptome/Genome scan level: 0 to 2. 0: Report the first mapping. 1:
      Continue processing the read unless it is perfectly mapped to cDNA. 2: Report
      the best mapping.'
    default: 0
    inputBinding:
      position: 101
      prefix: --scan-lev
  - id: seed_occurrence_limit
    type:
      - 'null'
      - int
    doc: Skip seeds that have more than INT occurrences
    default: 500
    inputBinding:
      position: 101
      prefix: --seed-lim
  - id: seq
    type:
      - 'null'
      - File
    doc: Single-end sequence file.
    inputBinding:
      position: 101
      prefix: --seq
  - id: seq1
    type:
      - 'null'
      - File
    doc: 1st paired-end sequence file.
    inputBinding:
      position: 101
      prefix: --seq1
  - id: seq2
    type:
      - 'null'
      - File
    doc: 2nd paired-end sequence file.
    inputBinding:
      position: 101
      prefix: --seq2
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --thread
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity mode: 0 or 1. Higher values output more information'
    default: 0
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circminer:0.4.2--h5ca1c30_6
stdout: circminer.out
