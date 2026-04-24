cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdp-alignment_rm-partialseq
label: rdp-alignment_rm-partialseq
doc: "Performs alignment of sequences, marking partial sequences based on gap count.\n\
  \nTool homepage: https://github.com/AlbertoMartinPerez/Sequence_Analyzer_automations"
inputs:
  - id: fulllengthSeqFile
    type: File
    doc: File containing full-length sequences.
    inputBinding:
      position: 1
  - id: queryFile
    type: File
    doc: File containing query sequences.
    inputBinding:
      position: 2
  - id: alignment_mode
    type:
      - 'null'
      - string
    doc: 'Alignment mode: overlap, glocal, local or global.'
    inputBinding:
      position: 103
      prefix: --alignment-mode
  - id: knn
    type:
      - 'null'
      - int
    doc: The top k closest targets using a heuristic method.
    inputBinding:
      position: 103
      prefix: --knn
  - id: min_gaps
    type:
      - 'null'
      - int
    doc: The minimum number of continuous gaps in the beginning or end of the 
      query alignment. If above the cutoff, the query is marked as partial.
    inputBinding:
      position: 103
      prefix: --min_gaps
outputs:
  - id: passedSeqOutFile
    type: File
    doc: Output file for passed sequences.
    outputBinding:
      glob: '*.out'
  - id: alignment_out
    type:
      - 'null'
      - File
    doc: The output file containing the pairwise alignment
    outputBinding:
      glob: $(inputs.alignment_out)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-alignment:v1.2.0-5-deb_cv1
