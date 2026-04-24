cwlVersion: v1.2
class: CommandLineTool
baseCommand: miranda
label: miranda
doc: "microRNA Target Scanning Algorithm. miRAnda is an miRNA target scanner which
  aims to predict mRNA targets for microRNAs using dynamic-programming alignment and
  thermodynamics.\n\nTool homepage: https://github.com/miranda-ng/miranda-ng"
inputs:
  - id: file1
    type: File
    doc: a FASTA file with a microRNA query
    inputBinding:
      position: 1
  - id: file2
    type: File
    doc: a FASTA file containing the sequence(s) to be scanned.
    inputBinding:
      position: 2
  - id: energy_threshold
    type:
      - 'null'
      - float
    doc: Set energy threshold to -E kcal/mol
    inputBinding:
      position: 103
      prefix: -E
  - id: gap_extend_penalty
    type:
      - 'null'
      - float
    doc: Set gap-extend penalty to -Y
    inputBinding:
      position: 103
      prefix: -Y
  - id: gap_open_penalty
    type:
      - 'null'
      - float
    doc: Set gap-open penalty to -X
    inputBinding:
      position: 103
      prefix: -X
  - id: keyval
    type:
      - 'null'
      - boolean
    doc: Key value pairs ??
    inputBinding:
      position: 103
      prefix: -keyval
  - id: no_thermodynamics
    type:
      - 'null'
      - boolean
    doc: Do not perform thermodynamics
    inputBinding:
      position: 103
      prefix: -noenergy
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Output fewer event notifications
    inputBinding:
      position: 103
      prefix: -quiet
  - id: restrict_file
    type:
      - 'null'
      - File
    doc: Restricts scans to those between specific miRNAs and UTRs provided in a
      pairwise tab-separated file
    inputBinding:
      position: 103
      prefix: -restrict
  - id: scaling_parameter
    type:
      - 'null'
      - float
    doc: Set scaling parameter to Z
    inputBinding:
      position: 103
      prefix: -scale
  - id: score_threshold
    type:
      - 'null'
      - float
    doc: Set score threshold to S
    inputBinding:
      position: 103
      prefix: -sc
  - id: strict_seed_pairing
    type:
      - 'null'
      - boolean
    doc: Demand strict 5' seed pairing
    inputBinding:
      position: 103
      prefix: -strict
  - id: trim_reference
    type:
      - 'null'
      - int
    doc: Trim reference sequences to T nt
    inputBinding:
      position: 103
      prefix: -trim
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output results to file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/miranda:3.3a--h7b50bb2_9
