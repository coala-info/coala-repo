cwlVersion: v1.2
class: CommandLineTool
baseCommand: pairaln
label: smartdenovo_pairaln
doc: "pairaln: align pairs of sequences (read1 vs read2, read3 vs read4, ...) from standard input; default parameters suit PacBio long reads (SMARTdenovo)\n\nTool homepage: https://github.com/ruanjue/smartdenovo"
stdin: $(inputs.sequences.path)
inputs:
  - id: sequences
    type: File
    doc: "FASTA or FASTQ file with paired sequences, read from standard input (read1, read2, read3, read4, ...)"
  - id: both_strands
    type:
      - 'null'
      - boolean
    doc: "Try both strands"
    inputBinding:
      position: 101
      prefix: -s
  - id: penalty_match
    type:
      - 'null'
      - int
    doc: "Alignment penalty: match, [2]"
    inputBinding:
      position: 101
      prefix: -M
  - id: penalty_mismatch
    type:
      - 'null'
      - int
    doc: "Alignment penalty: mismatch, [-5]"
    inputBinding:
      position: 101
      prefix: -X
  - id: penalty_indel
    type:
      - 'null'
      - int
    doc: "Alignment penalty: insertion or deletion, [-3]"
    inputBinding:
      position: 101
      prefix: -O
  - id: penalty_gap_extension
    type:
      - 'null'
      - int
    doc: "Alignment penalty: gap extension, [-1]"
    inputBinding:
      position: 101
      prefix: -E
  - id: penalty_end_clipping
    type:
      - 'null'
      - int
    doc: "Alignment penalty: read end clipping, 0: disable HSP extension, otherwise set to -100 or other [-100]"
    inputBinding:
      position: 101
      prefix: -T
  - id: bandwidth
    type:
      - 'null'
      - int
    doc: "Bandwidth, [800]"
    inputBinding:
      position: 101
      prefix: -W
  - id: output_alignment
    type:
      - 'null'
      - boolean
    doc: "Output alignment"
    inputBinding:
      position: 101
      prefix: -a
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
stdout: smartdenovo_pairaln.out
