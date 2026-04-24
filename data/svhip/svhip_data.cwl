cwlVersion: v1.2
class: CommandLineTool
baseCommand: svhip.py
label: svhip_data
doc: "Processes input data for svhip, potentially generating control datasets and
  optimizing alignments.\n\nTool homepage: https://github.com/chrisBioInf/Svhip"
inputs:
  - id: generate_control
    type:
      - 'null'
      - boolean
    doc: 'Flag to determine if a negative set should be auto-generated (Default: False).'
    inputBinding:
      position: 101
      prefix: --generate-control
  - id: hexamer_model
    type:
      - 'null'
      - File
    doc: The Location of the statistical Hexamer model to use. An example file 
      is included with the download as Human_hexamer.tsv, which will be used as 
      a fallback.
    inputBinding:
      position: 101
      prefix: --hexamer-model
  - id: input_file
    type: File
    doc: The input directory or file (Required).
    inputBinding:
      position: 101
      prefix: --input
  - id: max_id
    type:
      - 'null'
      - int
    doc: During data preprocessing, sequences above identity threshold (in 
      percent) will be removed.
    inputBinding:
      position: 101
      prefix: --max-id
  - id: negative_data
    type:
      - 'null'
      - string
    doc: Should a specific negative data set be supplied for data generation? If
      this field is EMPTY it will be auto-generated based on the data at hand 
      (This will be the desired option for most uses).
    inputBinding:
      position: 101
      prefix: --negative
  - id: no_structural_filter
    type:
      - 'null'
      - boolean
    doc: 'Set this flag to True if no filtering of alignment windows for statistical
      significance of structure should occur (Default: False).'
    inputBinding:
      position: 101
      prefix: --no-structural-filter
  - id: num_sequences
    type:
      - 'null'
      - int
    doc: Number of sequences input alignments will be optimized towards.
    inputBinding:
      position: 101
      prefix: --num-sequences
  - id: num_windows
    type:
      - 'null'
      - int
    doc: The number of times the alignment should be fully sliced in windows - 
      for variation.
    inputBinding:
      position: 101
      prefix: --windows
  - id: positive_label
    type:
      - 'null'
      - string
    doc: The label that should be assigned to the feature vectors generated from
      the (non-control) input data. Can be CDS (for protein coding sequences) or
      ncRNA.
    inputBinding:
      position: 101
      prefix: --positive-label
  - id: shuffle_control
    type:
      - 'null'
      - boolean
    doc: 'Use the column-based shuffling approach provided by the RNAz framework instead
      of SISSIz (Default: False).'
    inputBinding:
      position: 101
      prefix: --shuffle-control
  - id: slide
    type:
      - 'null'
      - int
    doc: Controls the step size during alignment slicing and thereby the overlap
      of each window.
    inputBinding:
      position: 101
      prefix: --slide
  - id: tree_path
    type:
      - 'null'
      - File
    doc: If an evolutionary tree of species in the alignment is available in 
      Newick format, you can pass it here. Names have to be identical. If None 
      is passed, one will be estimated based on sequences at hand.
    inputBinding:
      position: 101
      prefix: --tree
  - id: window_length
    type:
      - 'null'
      - int
    doc: Length of overlapping windows that alignments will be sliced into.
    inputBinding:
      position: 101
      prefix: --window-length
outputs:
  - id: output_file
    type: Directory
    doc: Name for the output directory (Required).
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svhip:1.0.9--hdfd78af_0
