cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rdp-readseq
  - rm-dupseq
label: rdp-readseq_rm-dupseq
doc: "Remove identical sequences or sequences contained in another sequence (RmRedundantSeqs).

Tool homepage: https://github.com/rdpstaff/ReadSeq"
inputs:
  - id: infile
    type: File
    doc: "Input fasta file"
    inputBinding:
      position: 1
      prefix: --infile
  - id: outfile
    type: string
    doc: "Output fasta file"
    inputBinding:
      position: 2
      prefix: --outfile
  - id: duplicates
    type:
      - 'null'
      - boolean
    doc: "Remove identical sequence, or sequence contained by another sequence"
    inputBinding:
      position: 3
      prefix: --duplicates
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Output the ids that are contained by other sequences to standard out"
    inputBinding:
      position: 4
      prefix: --debug
  - id: min_seq_length
    type:
      - 'null'
      - int
    doc: "Filter sequences by minimum sequence length, default is 0"
    inputBinding:
      position: 5
      prefix: --min_seq_length
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out
    type:
      - 'null'
      - File
    doc: "Output fasta file"
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
stdout: rdp-readseq_rm-dupseq.out
