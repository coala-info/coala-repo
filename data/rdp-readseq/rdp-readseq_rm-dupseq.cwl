cwlVersion: v1.2
class: CommandLineTool
baseCommand: RmRedundantSeqs
label: rdp-readseq_rm-dupseq
doc: Remove redundant sequences from a FASTA file.
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output the ids that are contained by other sequences to standard out
    inputBinding:
      position: 101
      prefix: --debug
  - id: infile
    type: File
    doc: input fasta file
    inputBinding:
      position: 101
      prefix: --infile
  - id: min_seq_length
    type:
      - 'null'
      - int
    doc: filter sequence by minimum sequence length
    default: 0
    inputBinding:
      position: 101
      prefix: --min_seq_length
  - id: remove_identical
    type:
      - 'null'
      - boolean
    doc: remove identical sequence, or sequence contained by another sequence
    inputBinding:
      position: 101
      prefix: --duplicates
outputs:
  - id: outfile
    type: File
    doc: output fasta file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
