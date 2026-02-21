cwlVersion: v1.2
class: CommandLineTool
baseCommand: aprfinder
label: aprfinder
doc: "tool for a-phased repeat search.\n\nTool homepage: https://github.com/jaroslav-kubin/aprfinder"
inputs:
  - id: exact_at
    type:
      - 'null'
      - int
    doc: Sets max-AT and min-AT to the same value.
    inputBinding:
      position: 101
      prefix: --exact-AT
  - id: exact_bound
    type:
      - 'null'
      - int
    doc: Sets lower-bound and upper-bound to the same value.
    inputBinding:
      position: 101
      prefix: --exact-bound
  - id: exact_tracks
    type:
      - 'null'
      - int
    doc: Sets min-tracks and max-tracks to the same value.
    inputBinding:
      position: 101
      prefix: --exact-tracks
  - id: input
    type:
      - 'null'
      - File
    doc: Input FASTA or MULTIFASTA file.
    inputBinding:
      position: 101
      prefix: --input
  - id: lower_bound
    type:
      - 'null'
      - int
    doc: Minimum size of spacer.
    inputBinding:
      position: 101
      prefix: --lower-bound
  - id: max_at
    type:
      - 'null'
      - int
    doc: Maximum number of consecutive A/T nucleotides.
    inputBinding:
      position: 101
      prefix: --max-AT
  - id: max_tracks
    type:
      - 'null'
      - int
    doc: Minimum number of tracks to consider a sequence to be an a-phased repeat.
    inputBinding:
      position: 101
      prefix: --max-tracks
  - id: memory_size
    type:
      - 'null'
      - int
    doc: Memory size limit for the search process.
    inputBinding:
      position: 101
      prefix: --memory-size
  - id: min_at
    type:
      - 'null'
      - int
    doc: Minimum number of consecutive A/T nucleotides.
    inputBinding:
      position: 101
      prefix: --min-AT
  - id: min_tracks
    type:
      - 'null'
      - int
    doc: Minimum number of tracks to consider a sequence to be an a-phased repeat.
    inputBinding:
      position: 101
      prefix: --min-tracks
  - id: upper_bound
    type:
      - 'null'
      - int
    doc: Maximum size of spacer.
    inputBinding:
      position: 101
      prefix: --upper-bound
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Defines output file name. Note that <string> should be in format <name>.gff.
      If not defined, output is set to result.gff.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aprfinder:1.5--h7b50bb2_3
