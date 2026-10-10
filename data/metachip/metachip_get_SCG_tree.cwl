cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MetaCHIP
  - get_SCG_tree
label: metachip_get_SCG_tree
doc: "Build a single-copy gene (SCG) protein tree from a folder of genomes with
  Prodigal, HMMER, Mafft and FastTree.\n\nTool homepage: https://github.com/songweizhi/MetaCHIP"
inputs:
  - id: genome_dir
    type: Directory
    doc: input genome folder
    inputBinding:
      prefix: -i
  - id: prefix
    type: string
    doc: output prefix
    inputBinding:
      prefix: -p
  - id: extension
    type: ['null', string]
    doc: file extension
    inputBinding:
      prefix: -x
  - id: nonmeta
    type: ['null', boolean]
    doc: annotate Non-metagenome-assembled genomes (Non-MAGs)
    inputBinding:
      prefix: -nonmeta
  - id: threads
    type: ['null', int]
    doc: 'number of threads, default: 1'
    inputBinding:
      prefix: -t
outputs:
  - id: tree
    type: File
    doc: SCG tree in newick format
    outputBinding:
      glob: "$(inputs.prefix)_get_SCG_tree_wd/$(inputs.prefix)_SCG_tree.newick"
  - id: alignment
    type: ['null', File]
    doc: concatenated SCG alignment used for the tree
    outputBinding:
      glob: "$(inputs.prefix)_get_SCG_tree_wd/$(inputs.prefix)_SCG_tree_cov50_css25.aln"
  - id: log
    type: ['null', File]
    doc: log file
    outputBinding:
      glob: "$(inputs.prefix)_get_SCG_tree_wd/$(inputs.prefix)_get_SCG_tree.log"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metachip:1.10.13--pyh7cba7a3_0
