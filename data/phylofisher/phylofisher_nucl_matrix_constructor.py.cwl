cwlVersion: v1.2
class: CommandLineTool
baseCommand: nucl_matrix_constructor.py
label: phylofisher_nucl_matrix_constructor.py
doc: "To get nucleotides trim align and concatenate orthologs into a nucleotide super-matrix:\n\
  \nTool homepage: https://github.com/TheBrownLab/PhyloFisher"
inputs:
  - id: clean_up
    type:
      - 'null'
      - boolean
    doc: Clean up large intermediate files.
    inputBinding:
      position: 101
      prefix: --clean_up
  - id: in_format
    type:
      - 'null'
      - string
    doc: "Format of the input files.\n                                 Options: fasta,
      phylip (names truncated at 10 characters), \n                              \
      \   phylip-relaxed (names are not truncated), or nexus."
    default: fasta
    inputBinding:
      position: 101
      prefix: --in_format
  - id: input_dir
    type: Directory
    doc: Path to prep_final_dataset_<M.D.Y>
    inputBinding:
      position: 101
      prefix: --input
  - id: input_tsv
    type: File
    doc: Path to input tsv file which contains unique IDs and paths to 
      nucleotide files.
    inputBinding:
      position: 101
      prefix: --input_tsv
  - id: out_format
    type:
      - 'null'
      - string
    doc: "Desired format of the output matrix.\n                                 Options:
      fasta, phylip (names truncated at 10 characters), \n                       \
      \          phylip-relaxed (names are not truncated), or nexus."
    default: fasta
    inputBinding:
      position: 101
      prefix: --out_format
  - id: threads
    type:
      - 'null'
      - int
    doc: Desired number of threads to be utilized.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to user-defined output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylofisher:1.2.14--pyhdfd78af_0
