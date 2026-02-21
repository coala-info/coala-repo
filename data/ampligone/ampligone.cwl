cwlVersion: v1.2
class: CommandLineTool
baseCommand: AmpliGone
label: ampligone
doc: "An accurate and efficient tool to remove primers from NGS reads in reference-based
  experiments\n\nTool homepage: https://rivm-bioinformatics.github.io/AmpliGone/"
inputs:
  - id: alignment_preset
    type:
      - 'null'
      - string
    doc: The preset to use for alignment of reads against the reference ('sr', 'map-ont',
      'map-pb', or 'splice').
    inputBinding:
      position: 101
      prefix: --alignment-preset
  - id: alignment_scoring
    type:
      - 'null'
      - type: array
        items: string
    doc: The scoring matrix to use for alignment of reads. This should be list of
      key-value pairs (e.g., match=4 mismatch=3).
    inputBinding:
      position: 101
      prefix: --alignment-scoring
  - id: always_output
    type:
      - 'null'
      - boolean
    doc: If set, AmpliGone will always create the output files even if there is nothing
      to output.
    default: false
    inputBinding:
      position: 101
      prefix: -to
  - id: amplicon_type
    type:
      - 'null'
      - string
    doc: Define the amplicon-type, either being 'end-to-end', 'end-to-mid', or 'fragmented'.
    default: end-to-end
    inputBinding:
      position: 101
      prefix: --amplicon-type
  - id: error_rate
    type:
      - 'null'
      - float
    doc: The maximum allowed error rate (as a percentage) for the primer search. Use
      0 for exact primer matches.
    default: 0.1
    inputBinding:
      position: 101
      prefix: --error-rate
  - id: fragment_lookaround_size
    type:
      - 'null'
      - int
    doc: The number of bases to look around a primer-site to consider it part of a
      fragment. Only used if amplicon-type is 'fragmented'.
    default: 10
    inputBinding:
      position: 101
      prefix: --fragment-lookaround-size
  - id: input
    type: File
    doc: Input file with reads in either FastQ or BAM format.
    inputBinding:
      position: 101
      prefix: --input
  - id: primers
    type: File
    doc: Used primer sequences in FASTA format or primer coordinates in BED format.
    inputBinding:
      position: 101
      prefix: --primers
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Prints less information, like only WARNING and ERROR statements, to the terminal
    default: false
    inputBinding:
      position: 101
      prefix: --quiet
  - id: reference
    type: File
    doc: Input Reference genome in FASTA format
    inputBinding:
      position: 101
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads you wish to use.
    default: 2
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Prints more information, like DEBUG statements, to the terminal
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
  - id: virtual_primers
    type:
      - 'null'
      - boolean
    doc: If set, primers closely positioned to each other in the same orientation
      will be virtually combined into a single primer.
    default: false
    inputBinding:
      position: 101
      prefix: --virtual-primers
outputs:
  - id: output
    type: File
    doc: Output (FastQ) file with cleaned reads.
    outputBinding:
      glob: $(inputs.output)
  - id: export_primers
    type:
      - 'null'
      - File
    doc: Output BED file with found primer coordinates if they are actually cut from
      the reads
    outputBinding:
      glob: $(inputs.export_primers)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ampligone:2.0.2--pyhdfd78af_0
