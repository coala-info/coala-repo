cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapgreen
label: rapgreen
doc: "RAP-Green v1.0\n\nTool homepage: https://github.com/SouthGreenPlatform/rap-green"
inputs:
  - id: distance_weight
    type:
      - 'null'
      - float
    doc: The weight of evolutionary distance in functional orthology scoring 
      (0.0 for maximum weight, 1.0 for no weight, optional, default 0.10)
    default: 0.1
    inputBinding:
      position: 101
      prefix: -distw
  - id: ending_index
    type:
      - 'null'
      - int
    doc: The ending exclusive index (directory size default), if the gene tree 
      input is a directory
    inputBinding:
      position: 101
      prefix: -end
  - id: gene_threshold
    type:
      - 'null'
      - float
    doc: The support threshold for gene tree branch collapse (optional, default 
      80.0)
    default: 80.0
    inputBinding:
      position: 101
      prefix: -gt
  - id: gene_tree_file
    type:
      - 'null'
      - File
    doc: The input gene tree file
    inputBinding:
      position: 101
      prefix: -g
  - id: i_duplication_weight
    type:
      - 'null'
      - float
    doc: The weight of intersection duplication in functional orthology scoring 
      (0.0 for maximum weight, 1.0 for no weight, optional, default 0.90)
    default: 0.9
    inputBinding:
      position: 101
      prefix: -idupw
  - id: invert
    type:
      - 'null'
      - boolean
    doc: Activate this option if your taxa identifier is in front of the 
      sequence identifier
    inputBinding:
      position: 101
      prefix: -invert
  - id: k_level
    type:
      - 'null'
      - int
    doc: The k-level of the subtree-neighbor measure (optional, default 2)
    default: 2
    inputBinding:
      position: 101
      prefix: -k
  - id: outparalogous
    type:
      - 'null'
      - boolean
    doc: Add outparalogous informations in stats file.
    inputBinding:
      position: 101
      prefix: -outparalogous
  - id: pipe
    type:
      - 'null'
      - boolean
    doc: Activate this option if your taxa identifier contains pipes instead of 
      underscores
    inputBinding:
      position: 101
      prefix: -pipe
  - id: polymorphism_threshold
    type:
      - 'null'
      - float
    doc: The length depth threshold to deduce to polymorphism, allelism ... 
      (optional, default 0.05)
    default: 0.05
    inputBinding:
      position: 101
      prefix: -pt
  - id: prefix_taxa
    type:
      - 'null'
      - string
    doc: A prefix to be translated to a specific taxa, in sequence name.
    inputBinding:
      position: 101
      prefix: -prefix
  - id: rerooted_gene_tree_file
    type:
      - 'null'
      - File
    doc: The simple unannotated rerooted gene tree file
    inputBinding:
      position: 101
      prefix: -rerooted
  - id: rerooted_species_gene_tree_file
    type:
      - 'null'
      - File
    doc: The simple unannotated rerooted gene tree file, with only species on 
      the leaf (for supertrees for example)
    inputBinding:
      position: 101
      prefix: -rerootedSpecies
  - id: speciation_weight
    type:
      - 'null'
      - float
    doc: The weight of speciation in functional orthology scoring (0.0 for 
      maximum weight, 1.0 for no weight, optional, default 0.99)
    default: 0.99
    inputBinding:
      position: 101
      prefix: -specw
  - id: species_threshold
    type:
      - 'null'
      - float
    doc: The length threshold for species tree branch collapse (optional, 
      default 10.0)
    default: 10.0
    inputBinding:
      position: 101
      prefix: -st
  - id: species_tree_file
    type:
      - 'null'
      - File
    doc: The input species tree file
    inputBinding:
      position: 101
      prefix: -s
  - id: starting_index
    type:
      - 'null'
      - int
    doc: The starting index (0 default), if the gene tree input is a directory
    default: 0
    inputBinding:
      position: 101
      prefix: -start
  - id: t_duplication_weight
    type:
      - 'null'
      - float
    doc: The weight of topological duplication in functional orthology scoring 
      (0.0 for maximum weight, 1.0 for no weight, optional, default 0.95)
    default: 0.95
    inputBinding:
      position: 101
      prefix: -tdupw
  - id: ultraparalogy_weight
    type:
      - 'null'
      - float
    doc: The weight of an ultraparalogy node in functional orthology scoring 
      (0.0 for maximum weight, 1.0 for no weight, optional, default 0.99)
    default: 0.99
    inputBinding:
      position: 101
      prefix: -ultraw
outputs:
  - id: gene_tree_nhx_file
    type:
      - 'null'
      - File
    doc: The output tree file (annotated with duplications) in NHX format
    outputBinding:
      glob: $(inputs.gene_tree_nhx_file)
  - id: stats_gene_tree_file
    type:
      - 'null'
      - File
    doc: The output scoring statistic file
    outputBinding:
      glob: $(inputs.stats_gene_tree_file)
  - id: output_species_tree_file
    type:
      - 'null'
      - File
    doc: The output species tree file (limited to gene tree species)
    outputBinding:
      glob: $(inputs.output_species_tree_file)
  - id: reconciled_tree_file
    type:
      - 'null'
      - File
    doc: The output reconciled tree file (consensus tree, with reductions and 
      losses)
    outputBinding:
      glob: $(inputs.reconciled_tree_file)
  - id: output_gene_tree_file
    type:
      - 'null'
      - File
    doc: The output tree file (annotated with duplications)
    outputBinding:
      glob: $(inputs.output_gene_tree_file)
  - id: gene_tree_phyloxml_file
    type:
      - 'null'
      - File
    doc: The output tree file (annotated with duplications) in phyloXML format
    outputBinding:
      glob: $(inputs.gene_tree_phyloxml_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rapgreen:1.0--hdfd78af_0
