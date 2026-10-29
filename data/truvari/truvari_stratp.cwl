cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - stratp
label: truvari_stratp
doc: "Stratification Performance Test\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: features
    type:
      - 'null'
      - string
    doc: Comma-separated list of categorical features to score (e.g. svtype,szbin)
    inputBinding:
      position: 1
      prefix: "--features"
  - id: states
    type:
      - 'null'
      - type: enum
        symbols:
          - base
          - comp
    doc: Score VCF entries from (base)line or (comp)arison (default:base)
    inputBinding:
      position: 1
      prefix: "--states"
  - id: preset
    type:
      - 'null'
      - type: enum
        symbols:
          - mims
          - giab1.1
    doc: Preset features to score
    inputBinding:
      position: 1
      prefix: "--preset"
  - id: output
    type:
      - 'null'
      - string
    default: stratp_scores.tsv
    doc: Score output tsv file (stdout)
    inputBinding:
      position: 1
      prefix: "-o"
  - id: count_output
    type:
      - 'null'
      - string
    doc: Stratification variant count tsv file
    inputBinding:
      position: 1
      prefix: "-c"
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbose logging
    inputBinding:
      position: 1
      prefix: "--debug"
  - id: min_obs
    type:
      - 'null'
      - int
    doc: Minimum observation for a bin (10)
    inputBinding:
      position: 1
      prefix: "--min-obs"
  - id: nperm
    type:
      - 'null'
      - int
    doc: Number of permutations to perform (10000)
    inputBinding:
      position: 1
      prefix: "--nperm"
  - id: tail
    type:
      - 'null'
      - type: enum
        symbols:
          - left
          - right
          - two
    doc: Tail to test (left)
    inputBinding:
      position: 1
      prefix: "--tail"
  - id: alpha
    type:
      - 'null'
      - float
    doc: Significance threshold (0.01)
    inputBinding:
      position: 1
      prefix: "--alpha"
  - id: check_co
    type:
      - 'null'
      - float
    doc: Check if features co-occur and warns if phi >= threshold. Requires scipy. (-1=off)
    inputBinding:
      position: 1
      prefix: "--check-co"
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for permutation tests (42)
    inputBinding:
      position: 1
      prefix: "--seed"
  - id: dir
    type: Directory
    doc: Truvari bench result directory
    inputBinding:
      position: 2
outputs:
  - id: output_tsv
    type: File
    doc: Score table
    outputBinding:
      glob: "$(inputs.output)"
  - id: count_tsv
    type:
      - 'null'
      - File
    doc: Stratification variant counts (with --count-output)
    outputBinding:
      glob: "$(inputs.count_output)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$(inputs.dir)"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
