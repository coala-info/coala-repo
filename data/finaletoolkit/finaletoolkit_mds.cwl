cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - finaletoolkit
  - mds
label: finaletoolkit_mds
doc: "Calculate the frequency of end motifs in fragments.\n\nTool homepage: https://github.com/epifluidlab/FinaleToolkit"
inputs:
  - id: input_file
    type: File
    doc: Input file containing fragment data.
    inputBinding:
      position: 1
  - id: header
    type:
      - 'null'
      - int
    doc: Line number of the header in the input file (0-indexed).
    inputBinding:
      position: 102
      prefix: --header
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum fragment length to consider.
    inputBinding:
      position: 102
      prefix: --max-len
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum fragment length to consider.
    default: 1
    inputBinding:
      position: 102
      prefix: --min-len
  - id: motif_len
    type:
      - 'null'
      - int
    doc: Length of the end motifs to analyze.
    default: 5
    inputBinding:
      position: 102
      prefix: --motif-len
  - id: sep
    type:
      - 'null'
      - string
    doc: Separator used in the input file.
    default: \t
    inputBinding:
      position: 102
      prefix: --sep
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for computation.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to save the motif frequencies.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
