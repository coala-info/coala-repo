cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyclone_map
label: phyclone_map
doc: "Build MAP results.\n\nTool homepage: https://github.com/Roth-Lab/PhyClone"
inputs:
  - id: in_file
    type: File
    doc: "Path to trace file from MCMC analysis.\n                               \
      \   Format is HDF5."
    inputBinding:
      position: 101
      prefix: --in-file
  - id: map_type
    type:
      - 'null'
      - string
    doc: Which measure to use as for MAP computation.
    default: joint-likelihood
    inputBinding:
      position: 101
      prefix: --map-type
outputs:
  - id: out_table_file
    type: File
    outputBinding:
      glob: $(inputs.out_table_file)
  - id: out_tree_file
    type: File
    doc: "Path to where tree will be written in\n                                \
      \  minimal newick format."
    outputBinding:
      glob: $(inputs.out_tree_file)
  - id: out_sample_prev_table
    type:
      - 'null'
      - File
    doc: "Path to where sample prevalence table will\n                           \
      \       be written in .tsv format."
    outputBinding:
      glob: $(inputs.out_sample_prev_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyclone:0.8.0--pyhdfd78af_0
