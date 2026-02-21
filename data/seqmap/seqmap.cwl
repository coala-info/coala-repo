cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqmap
label: seqmap
doc: "A tool for mapping short sequences to a reference genome, allowing for a specified
  number of mismatches or insertions/deletions.\n\nTool homepage: http://www-personal.umich.edu/~jianghui/seqmap/"
inputs:
  - id: mismatches
    type: int
    doc: Number of mismatches (or total edit distance) allowed.
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: Input FASTA/FASTQ file containing short reads.
    inputBinding:
      position: 2
  - id: reference_file
    type: File
    doc: Reference genome file in FASTA format.
    inputBinding:
      position: 3
  - id: allow_ins_del
    type:
      - 'null'
      - boolean
    doc: Allow insertions and deletions.
    inputBinding:
      position: 104
      prefix: /insdel
  - id: exact_match
    type:
      - 'null'
      - boolean
    doc: Filter for exact matches only.
    inputBinding:
      position: 104
      prefix: /exact
  - id: forward_only
    type:
      - 'null'
      - boolean
    doc: Map to forward strand only.
    inputBinding:
      position: 104
      prefix: /forward
  - id: output_top_hits
    type:
      - 'null'
      - int
    doc: Output only the top N hits for each read.
    inputBinding:
      position: 104
      prefix: '/output_top_hits:'
  - id: reverse_only
    type:
      - 'null'
      - boolean
    doc: Map to reverse strand only.
    inputBinding:
      position: 104
      prefix: /reverse
  - id: skip_all_with_more_than
    type:
      - 'null'
      - int
    doc: Skip reads with more than the specified number of hits.
    inputBinding:
      position: 104
      prefix: '/skip_all_with_more_than:'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output.
    inputBinding:
      position: 104
      prefix: /v
outputs:
  - id: output_file
    type: File
    doc: Output file for mapping results.
    outputBinding:
      glob: '*.out'
  - id: match_statistics
    type:
      - 'null'
      - File
    doc: Write match statistics to a file.
    outputBinding:
      glob: $(inputs.match_statistics)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqmap:1.0.13--h9948957_3
