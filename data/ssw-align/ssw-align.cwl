cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssw-align
label: ssw-align
doc: "Performs Smith-Waterman alignment on target and query sequences.\n\nTool homepage:
  https://github.com/kyu999/ssw_aligner"
inputs:
  - id: target_fasta
    type: File
    doc: Target FASTA file
    inputBinding:
      position: 1
  - id: query_file
    type: File
    doc: Query FASTA or FASTQ file
    inputBinding:
      position: 2
  - id: best_alignment_reverse_complement
    type:
      - 'null'
      - boolean
    doc: The best alignment will be picked between the original read alignment 
      and the reverse complement read alignment.
    inputBinding:
      position: 103
      prefix: -r
  - id: gap_extension_weight
    type:
      - 'null'
      - int
    doc: Weight for the gap extension.
    default: 1
    inputBinding:
      position: 103
      prefix: -e
  - id: gap_opening_weight
    type:
      - 'null'
      - int
    doc: Weight for the gap opening.
    default: 3
    inputBinding:
      position: 103
      prefix: -o
  - id: include_sam_header
    type:
      - 'null'
      - boolean
    doc: If -s is used, include header in SAM output.
    inputBinding:
      position: 103
      prefix: -h
  - id: min_score
    type:
      - 'null'
      - int
    doc: Only output the alignments with the Smith-Waterman score >= N.
    inputBinding:
      position: 103
      prefix: -f
  - id: output_sam
    type:
      - 'null'
      - boolean
    doc: Output in SAM format.
    inputBinding:
      position: 103
      prefix: -s
  - id: protein_alignment
    type:
      - 'null'
      - boolean
    doc: Do protein sequence alignment. Without this option, the ssw_test will 
      do genome sequence alignment.
    inputBinding:
      position: 103
      prefix: -p
  - id: return_alignment_path
    type:
      - 'null'
      - boolean
    doc: Return the alignment path.
    inputBinding:
      position: 103
      prefix: -c
  - id: weight_match
    type:
      - 'null'
      - int
    doc: Weight match in genome sequence alignment.
    default: 2
    inputBinding:
      position: 103
      prefix: -m
  - id: weight_matrix_file
    type:
      - 'null'
      - File
    doc: FILE is either the Blosum or Pam weight matrix.
    default: Blosum50
    inputBinding:
      position: 103
      prefix: -a
  - id: weight_mismatch
    type:
      - 'null'
      - int
    doc: Weight mismatch in genome sequence alignment.
    default: 2
    inputBinding:
      position: 103
      prefix: -x
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ssw-align:v1.1-2-deb_cv1
stdout: ssw-align.out
