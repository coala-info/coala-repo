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
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Report progress while aligning
    inputBinding:
      position: 102
      prefix: --verbose
  - id: annotation_file
    type:
      - 'null'
      - string
    doc: Write annotation for the multiple alignment to this file name
    inputBinding:
      position: 102
      prefix: -annot
  - id: alignment_order
    type:
      - 'null'
      - boolean
    doc: Print sequences in alignment order rather than input order
    inputBinding:
      position: 102
      prefix: --alignment-order
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 103
      prefix: --outfile
outputs:
  - id: annotation_output
    type:
      - 'null'
      - File
    doc: Annotation file
    outputBinding:
      glob: $(inputs.annotation_file)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify the output file name (default is stdout)
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msaprobs:0.9.7--h5ca1c30_5
