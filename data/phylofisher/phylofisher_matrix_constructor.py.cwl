cwlVersion: v1.2
class: CommandLineTool
baseCommand: matrix_constructor.py
label: phylofisher_matrix_constructor.py
doc: "To trim align and concatenate orthologs into a super-matrix run:\n\nTool homepage:
  https://github.com/TheBrownLab/PhyloFisher"
inputs:
  - id: clean_up
    type:
      - 'null'
      - boolean
    doc: Clean up large intermediate files.
    inputBinding:
      position: 101
      prefix: --clean_up
  - id: concatenation_only
    type:
      - 'null'
      - boolean
    doc: Only concatenate alignments. Trimming and alignment are not performed 
      automatically.
    inputBinding:
      position: 101
      prefix: --concatenation_only
  - id: in_format
    type:
      - 'null'
      - string
    doc: "Format of the input files.\n                                 Options: fasta,
      phylip (names truncated at 10 characters), \n                              \
      \   phylip-relaxed (names are not truncated), or nexus."
    inputBinding:
      position: 101
      prefix: --in_format
  - id: input_dir
    type: Directory
    doc: Path to prep_final_dataset_<M.D.Y>
    inputBinding:
      position: 101
      prefix: --input
  - id: out_format
    type:
      - 'null'
      - string
    doc: "Desired format of the output matrix.\n                                 Options:
      fasta, phylip (names truncated at 10 characters), \n                       \
      \          phylip-relaxed (names are not truncated), or nexus."
    inputBinding:
      position: 101
      prefix: --out_format
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix of input files\n                                 Example: path/to/input/prefix*"
    inputBinding:
      position: 101
      prefix: --prefix
  - id: suffix
    type:
      - 'null'
      - string
    doc: "Suffix of input files.\n                                 Example: path/to/input/*suffix"
    inputBinding:
      position: 101
      prefix: --suffix
  - id: threads
    type:
      - 'null'
      - int
    doc: Desired number of threads to be utilized.
    inputBinding:
      position: 101
      prefix: --threads
  - id: trimal_gt
    type:
      - 'null'
      - float
    doc: "trimaAL gt parameter. Fraction of sequences with a gap allowed.\n      \
      \                           Options: 0.0 - 1.0"
    inputBinding:
      position: 101
      prefix: --trimal_gt
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
