cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/PgRC
label: pgrc_PgRC
doc: "PgRC 2.0: A tool for genomic read compression and decompression.\n\nTool homepage:
  https://github.com/kowallus/PgRC"
inputs:
  - id: archive_name
    type: string
    doc: Name of the archive
    inputBinding:
      position: 1
  - id: pair_src_file
    type:
      - 'null'
      - File
    doc: Paired-end source file (used with -i)
    inputBinding:
      position: 2
  - id: decompression_mode
    type:
      - 'null'
      - boolean
    doc: decompression mode
    inputBinding:
      position: 103
      prefix: -d
  - id: disable_simplified_quality
    type:
      - 'null'
      - boolean
    doc: disable simplified quality estimation mode
    inputBinding:
      position: 103
      prefix: -Q
  - id: min_mismatch_chars
    type:
      - 'null'
      - int
    doc: minimalNumberOfCharsPerMismatchForReadsAlignmentPhase
    inputBinding:
      position: 103
      prefix: -M
  - id: min_rc_repeat_length
    type:
      - 'null'
      - int
    doc: minimalReverseComplementedRepeatLength
    inputBinding:
      position: 103
      prefix: -p
  - id: preserve_order
    type:
      - 'null'
      - boolean
    doc: preserve original read order information
    inputBinding:
      position: 103
      prefix: -o
  - id: quality_coefficient
    type:
      - 'null'
      - int
    doc: generatorBasedQualityCoefficientIn_% (0=>disable; 'ov' param in the paper)
    inputBinding:
      position: 103
      prefix: -g
  - id: quality_error_probability
    type:
      - 'null'
      - int
    doc: qualityStreamErrorProbability*1000 (1000=>disable)
    default: 1000
    inputBinding:
      position: 103
      prefix: -q
  - id: read_seed_length
    type:
      - 'null'
      - int
    doc: lengthOfReadSeedPartForReadsAlignmentPhase
    inputBinding:
      position: 103
      prefix: -s
  - id: seq_src_file
    type:
      - 'null'
      - File
    doc: Sequence source file
    inputBinding:
      position: 103
      prefix: -i
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads used
    default: 40
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgrc:2.0.2--h9948957_1
stdout: pgrc_PgRC.out
