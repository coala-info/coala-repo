cwlVersion: v1.2
class: CommandLineTool
baseCommand: GeneFamilyPhylogenyBuilder
label: plant_tribes_gene_family_phylogeny_builder_GeneFamilyPhylogenyBuilder
doc: "GENE FAMILY PHYLOGENETIC INFERENCE\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
inputs:
  - id: bootstrap_replicates
    type:
      - 'null'
      - int
    doc: "Number of replicates for rapid bootstrap analysis and search for the best-scoring
      ML tree\n                                    - requires \"--tree_inference\"\
      \ with RAxML"
    default: 100
    inputBinding:
      position: 101
      prefix: --bootstrap_replicates
  - id: config_dir
    type:
      - 'null'
      - Directory
    doc: "(Optional) Absolute path to the directory containing the default configuration
      files\n                                    for the selected scaffold defined
      by the value of the --scaffold parameter (e.g.,\n                          \
      \          /home/configs/22Gv1.1). If this parameter is not used, the directory
      containing the\n                                    default configuration files
      is set to ~home/config."
    inputBinding:
      position: 101
      prefix: --config_dir
  - id: max_orthogroup_size
    type:
      - 'null'
      - int
    doc: Maximum number of sequences in orthogroup alignments
    default: 100
    inputBinding:
      position: 101
      prefix: --max_orthogroup_size
  - id: method
    type:
      - 'null'
      - string
    doc: "Protein clustering method for the classification scaffold\n            \
      \                        If GFam: gfam\n                                   \
      \ If OrthoFinder: orthofinder\n                                    If OrthoMCL:
      orthomcl\n                                    If Other non PlantTribes method:
      methodname, where \"methodname\" a nonempty string of\n                    \
      \                word characters (alphanumeric or \"_\"). No embedded special
      charaters or white spaces."
    inputBinding:
      position: 101
      prefix: --method
  - id: min_orthogroup_size
    type:
      - 'null'
      - int
    doc: Minimum number of sequences in orthogroup alignments
    default: 4
    inputBinding:
      position: 101
      prefix: --min_orthogroup_size
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of threads (CPUs) to assign to external utilities (RAxML)
    default: 1
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: orthogroup_aln
    type: string
    doc: Directory containing gene family orthogroup alignment files
    inputBinding:
      position: 101
      prefix: --orthogroup_aln
  - id: rooting_order
    type:
      - 'null'
      - File
    doc: "File with a list of string fragments matching sequences identifiers of species
      in the \n                                    classification (including scaffold
      taxa) to be used for determining the most basal taxa in\n                  \
      \                  the orthogroups for rooting trees. Should be listed in decreasing
      order from older to younger\n                                    lineages. If
      the file is not provided, trees will be rooted using the most distant taxon\n\
      \                                    present in the orthogroup (see example
      rooting order configuration files in config sub-directory\n                \
      \                    of the installation). \n                              \
      \      - requires \"--tree_inference\" with RAxML"
    inputBinding:
      position: 101
      prefix: --rooting_order
  - id: scaffold
    type:
      - 'null'
      - string
    doc: "Orthogroups or gene families proteins scaffold.  This can either be an absolute\n\
      \                                    path to the directory containing the scaffolds
      (e.g., /home/scaffolds/22Gv1.1)\n                                    or just
      the scaffold (e.g., 22Gv1.1).  If the latter, ~home/data is prepended to\n \
      \                                   the scaffold to create the absolute path.\n\
      \                                    If Monocots clusters (version 1.0): 12Gv1.0\n\
      \                                    If Angiosperms clusters (version 1.0):
      22Gv1.0\n                                    If Angiosperms clusters (version
      1.1): 22Gv1.1\n                                    If Green plants clusters
      (version 1.0): 30Gv1.0\n                                    If Other non PlantTribes
      clusters: XGvY.Z, where \"X\" is the number species in the scaffold,\n     \
      \                               and \"Y.Z\" version number such as 12Gv1.0.
      Please look at one of the PlantTribes scaffold\n                           \
      \         data on how data files and directories are named, formated, and organized."
    inputBinding:
      position: 101
      prefix: --scaffold
  - id: tree_inference
    type: string
    doc: "Phylogenetic trees inference method\n                                  \
      \  If RAxML: raxml\n                                    If FastTree: fasttree"
    inputBinding:
      position: 101
      prefix: --tree_inference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/plant_tribes_gene_family_phylogeny_builder:1.0.4--0
stdout: 
  plant_tribes_gene_family_phylogeny_builder_GeneFamilyPhylogenyBuilder.out
