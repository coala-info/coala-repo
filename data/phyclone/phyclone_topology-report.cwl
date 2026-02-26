cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyclone_topology-report
label: phyclone_topology-report
doc: "Build topology report.\n\nTool homepage: https://github.com/Roth-Lab/PhyClone"
inputs:
  - id: in_file
    type: File
    doc: Path to trace file from MCMC analysis. Format is HDF5.
    inputBinding:
      position: 101
      prefix: --in-file
  - id: top_trees
    type:
      - 'null'
      - int
    doc: Number of uniquely sampled topologies to archive. Default is to produce
      an archive of all unique topologies.
    default: all unique topologies
    inputBinding:
      position: 101
      prefix: --top-trees
outputs:
  - id: out_file
    type: File
    doc: Path/filename to where topology report will be written in .tsv format
    outputBinding:
      glob: $(inputs.out_file)
  - id: topologies_archive
    type:
      - 'null'
      - File
    doc: To produce the results tables and newick trees for each uniquely 
      sampled topology in the report, provide a path to where the archive file 
      will be written in tar.gz compressed format.
    outputBinding:
      glob: $(inputs.topologies_archive)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyclone:0.8.0--pyhdfd78af_0
