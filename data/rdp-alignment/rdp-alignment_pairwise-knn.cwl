cwlVersion: v1.2
class: CommandLineTool
baseCommand: PairwiseKNN
label: rdp-alignment_pairwise-knn
doc: "Pairwise alignment tool using k-nearest neighbors\n\nTool homepage: https://github.com/AlbertoMartinPerez/Sequence_Analyzer_automations"
inputs:
  - id: query_file
    type: File
    doc: Query sequence file
    inputBinding:
      position: 1
  - id: db_file
    type: File
    doc: Database sequence file
    inputBinding:
      position: 2
  - id: k
    type:
      - 'null'
      - int
    doc: K-nearest neighbors to return.
    inputBinding:
      position: 103
      prefix: -k
  - id: mode
    type:
      - 'null'
      - string
    doc: Alignment mode {global, glocal, local, overlap, overlap_trimmed}
    inputBinding:
      position: 103
      prefix: --mode
  - id: prefilter
    type:
      - 'null'
      - int
    doc: The top p closest targets from kmer prefilter step. Set p=0 to disable 
      the prefilter step.
    inputBinding:
      position: 103
      prefix: --prefilter
  - id: word_size
    type:
      - 'null'
      - int
    doc: The word size used to find closest targets during prefilter.
    inputBinding:
      position: 103
      prefix: --word-size
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Redirect output to file instead of stdout
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-alignment:v1.2.0-5-deb_cv1
