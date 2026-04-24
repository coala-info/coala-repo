cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyclone consensus
label: phyclone_consensus
doc: "Build consensus results.\n\nTool homepage: https://github.com/Roth-Lab/PhyClone"
inputs:
  - id: consensus_threshold
    type:
      - 'null'
      - float
    doc: Consensus threshold to keep an SNV.
    inputBinding:
      position: 101
      prefix: --consensus-threshold
  - id: in_file
    type: File
    doc: Path to trace file from MCMC analysis. Format is HDF5.
    inputBinding:
      position: 101
      prefix: --in-file
  - id: weight_type
    type:
      - 'null'
      - string
    doc: Which measure to use as the consensus tree weights. Counts is the same 
      as an unweighted consensus.
    inputBinding:
      position: 101
      prefix: --weight-type
outputs:
  - id: out_table_file
    type: File
    doc: Output file path for the table.
    outputBinding:
      glob: $(inputs.out_table_file)
  - id: out_tree_file
    type: File
    doc: Path to where tree will be written in minimal newick format.
    outputBinding:
      glob: $(inputs.out_tree_file)
  - id: out_sample_prev_table
    type:
      - 'null'
      - File
    doc: Path to where sample prevalence table will be written in .tsv format.
    outputBinding:
      glob: $(inputs.out_sample_prev_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyclone:0.8.0--pyhdfd78af_0
