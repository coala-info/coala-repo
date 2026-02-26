cwlVersion: v1.2
class: CommandLineTool
baseCommand: msaprobs
label: msaprobs
doc: "MSAProbs is a multiple sequence alignment algorithm for protein sequences based
  on pair hidden Markov models and partition functions.\n\nTool homepage: http://msaprobs.sourceforge.net/homepage.htm"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input sequences in FASTA format
    inputBinding:
      position: 1
  - id: clustalw_format
    type:
      - 'null'
      - boolean
    doc: Use ClustalW output format instead of FASTA
    inputBinding:
      position: 102
      prefix: -clustalw
  - id: consistency_passes
    type:
      - 'null'
      - int
    doc: Number of passes of consistency transformation
    inputBinding:
      position: 102
      prefix: --consistency
  - id: iterative_refinement
    type:
      - 'null'
      - int
    doc: Number of passes of iterative refinement
    inputBinding:
      position: 102
      prefix: --iterative-refinement
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Specify the number of threads to use
    inputBinding:
      position: 102
      prefix: -num_threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify the output file name (default is stdout)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msaprobs:0.9.7--h5ca1c30_5
