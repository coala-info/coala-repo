cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rdp-alignment
  - rm-partialseq
label: rdp-alignment_rm-partialseq
doc: "Remove partial sequences, based on pairwise alignment to full-length reference sequences. Sequences can be protein or nucleotide.

Tool homepage: https://github.com/rdpstaff/Alignment"
inputs:
  - id: fulllength_seq_file
    type: File
    doc: "Full-length reference sequences"
    inputBinding:
      position: 5
  - id: query_file
    type: File
    doc: "Query sequences"
    inputBinding:
      position: 6
  - id: passed_seq_out_file
    type: string
    doc: "Output file for the sequences that passed"
    inputBinding:
      position: 7
  - id: alignment_mode
    type:
      - 'null'
      - string
    doc: "Alignment mode: overlap, glocal, local or global (default overlap)"
    inputBinding:
      position: 1
      prefix: --alignment-mode
  - id: min_gaps
    type:
      - 'null'
      - int
    doc: "The minimum number of continuous gaps at the start or end of the query alignment. Above the cutoff, the query is marked as partial (default 50)"
    inputBinding:
      position: 2
      prefix: --min_gaps
  - id: knn
    type:
      - 'null'
      - int
    doc: "The top k closest targets using a heuristic method (default 20)"
    inputBinding:
      position: 3
      prefix: --knn
  - id: alignment_out_path
    type:
      - 'null'
      - string
    doc: "Output file with the pairwise alignment"
    inputBinding:
      position: 4
      prefix: --alignment-out
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: passed_seq_out
    type:
      - 'null'
      - File
    doc: "Sequences that passed (not partial)"
    outputBinding:
      glob: $(inputs.passed_seq_out_file)
  - id: alignment_out
    type:
      - 'null'
      - File
    doc: "Pairwise alignment output"
    outputBinding:
      glob: $(inputs.alignment_out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-alignment:v1.2.0-5-deb_cv1
stdout: rdp-alignment_rm-partialseq.out
