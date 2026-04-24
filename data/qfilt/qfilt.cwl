cwlVersion: v1.2
class: CommandLineTool
baseCommand: qfilt
label: qfilt
doc: filter sequencing data using some simple heuristics
inputs:
  - id: fasta_qual_files
    type:
      type: array
      items: File
    doc: FASTA and QUAL files
    inputBinding:
      position: 101
      prefix: -F
  - id: fastq_file
    type: File
    doc: FASTQ file
    inputBinding:
      position: 101
      prefix: -Q
  - id: json_diagnostics
    type:
      - 'null'
      - boolean
    doc: output run diagnostics to stderr as JSON (default is to write ASCII 
      text)
    inputBinding:
      position: 101
      prefix: -j
  - id: max_low_quality_bases
    type:
      - 'null'
      - int
    doc: rather than splitting or truncating, remove reads which contain more 
      than COUNT low quality bases this option only works in COMBINATION with 
      the -P (punch) option
    inputBinding:
      position: 101
      prefix: -R
  - id: min_length
    type:
      - 'null'
      - int
    doc: minimum retained fragment LENGTH
    inputBinding:
      position: 101
      prefix: -l
  - id: min_qscore
    type:
      - 'null'
      - int
    doc: minimum per-base quality score below which a read will be split or 
      truncated
    inputBinding:
      position: 101
      prefix: -q
  - id: mode
    type:
      - 'null'
      - int
    doc: 'MODE is a 3-bitmask (an integer in [0-7], default=0): if the lowest bit
      is set, it is like passing -s; if the middle bit is set, it is like passing
      -p; and if the highest bit is set, it is like passing -a'
    inputBinding:
      position: 101
      prefix: -m
  - id: output_format
    type:
      - 'null'
      - string
    doc: output in FASTA or FASTQ format
    inputBinding:
      position: 101
      prefix: -f
  - id: prefix_mismatches
    type:
      - 'null'
      - int
    doc: if PREFIX is supplied, prefix matching tolerates at most MISMATCH 
      mismatches
    inputBinding:
      position: 101
      prefix: -t
  - id: replace_char
    type:
      - 'null'
      - string
    doc: rather than splitting or truncating, replace low quality bases with 
      CHAR this option OVERRIDES all -m mode options
    inputBinding:
      position: 101
      prefix: -P
  - id: retain_prefix
    type:
      - 'null'
      - string
    doc: if supplied, only reads with this PREFIX are retained, and the PREFIX 
      is stripped from each contributing read
    inputBinding:
      position: 101
      prefix: -T
  - id: split_on_low_qscore
    type:
      - 'null'
      - boolean
    doc: when encountering a low q-score, split instead of truncate
    inputBinding:
      position: 101
      prefix: -s
  - id: tolerate_low_qscore_ambiguous
    type:
      - 'null'
      - boolean
    doc: tolerate low q-score ambiguous nucleotides
    inputBinding:
      position: 101
      prefix: -a
  - id: tolerate_low_qscore_homopolymers
    type:
      - 'null'
      - boolean
    doc: tolerate low q-score homopolymeric regions
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: direct retained fragments to a file named OUTPUT
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qfilt:0.0.1--h9948957_7
