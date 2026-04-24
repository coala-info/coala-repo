cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssw_test
label: libssw_ssw_test
doc: "Performs Smith-Waterman alignment on target and query sequences.\n\nTool homepage:
  https://github.com/mengyao/Complete-Striped-Smith-Waterman-Library"
inputs:
  - id: target_fasta
    type: File
    doc: Target sequence in FASTA format
    inputBinding:
      position: 1
  - id: query_fasta_or_fastq
    type: File
    doc: Query sequence in FASTA or FASTQ format
    inputBinding:
      position: 2
  - id: best_alignment_between_original_and_reverse_complement
    type:
      - 'null'
      - boolean
    doc: The best alignment will be picked between the original read alignment 
      and the reverse complement read alignment
    inputBinding:
      position: 103
      prefix: -r
  - id: gap_extension_weight
    type:
      - 'null'
      - int
    doc: Weight for gap extension
    inputBinding:
      position: 103
      prefix: -e
  - id: gap_opening_weight
    type:
      - 'null'
      - int
    doc: Weight for gap opening
    inputBinding:
      position: 103
      prefix: -o
  - id: include_sam_header
    type:
      - 'null'
      - boolean
    doc: If -s is used, include header in SAM output
    inputBinding:
      position: 103
      prefix: -h
  - id: min_score
    type:
      - 'null'
      - int
    doc: Only output the alignments with the Smith-Waterman score >= N
    inputBinding:
      position: 103
      prefix: -f
  - id: output_sam
    type:
      - 'null'
      - boolean
    doc: Output in SAM format
    inputBinding:
      position: 103
      prefix: -s
  - id: protein_alignment
    type:
      - 'null'
      - boolean
    doc: Perform protein sequence alignment. Without this option, the ssw_test 
      will do genome sequence alignment.
    inputBinding:
      position: 103
      prefix: -p
  - id: return_alignment_path
    type:
      - 'null'
      - boolean
    doc: Return the alignment path
    inputBinding:
      position: 103
      prefix: -c
  - id: weight_match
    type:
      - 'null'
      - int
    doc: Weight for match in genome sequence alignment
    inputBinding:
      position: 103
      prefix: -m
  - id: weight_matrix_file
    type:
      - 'null'
      - File
    doc: FILE is either the Blosum or Pam weight matrix
    inputBinding:
      position: 103
      prefix: -a
  - id: weight_mismatch
    type:
      - 'null'
      - int
    doc: Weight for mismatch in genome sequence alignment
    inputBinding:
      position: 103
      prefix: -x
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libssw:1.2.5--h5ca1c30_0
stdout: libssw_ssw_test.out
