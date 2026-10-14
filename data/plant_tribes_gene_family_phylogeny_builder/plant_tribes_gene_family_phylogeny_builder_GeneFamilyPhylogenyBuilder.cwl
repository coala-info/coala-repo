cwlVersion: v1.2
class: CommandLineTool
baseCommand: GeneFamilyPhylogenyBuilder
label: plant_tribes_gene_family_phylogeny_builder_GeneFamilyPhylogenyBuilder
doc: "Gene family phylogenetic inference: infer trees from gene family orthogroup alignments with RAxML or FastTree. Results are written to the geneFamilyPhylogenies_dir folder in the working directory.\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: orthogroup_aln
    type: Directory
    doc: 'Directory containing gene family orthogroup alignment files'
    inputBinding:
      position: 101
      prefix: --orthogroup_aln
      valueFrom: $(self.path)
  - id: tree_inference
    type: string
    doc: 'Phylogenetic trees inference method: raxml or fasttree'
    inputBinding:
      position: 101
      prefix: --tree_inference
  - id: scaffold
    type:
      - 'null'
      - Directory
    doc: 'Orthogroups or gene families proteins scaffold directory (for example 22Gv1.1) (only with raxml; scaffold and method go together)'
    inputBinding:
      position: 101
      prefix: --scaffold
      valueFrom: $(self.path)
  - id: method
    type:
      - 'null'
      - string
    doc: 'Protein clustering method for the classification scaffold: gfam, orthofinder, orthomcl or another method name (only with raxml; scaffold and method go together)'
    inputBinding:
      position: 101
      prefix: --method
  - id: config_dir
    type:
      - 'null'
      - Directory
    doc: 'Directory containing the default configuration files for the selected scaffold (only with raxml; scaffold and method go together)'
    inputBinding:
      position: 101
      prefix: --config_dir
      valueFrom: $(self.path)
  - id: max_orthogroup_size
    type:
      - 'null'
      - int
    doc: 'Maximum number of sequences in orthogroup alignments (default 100)'
    inputBinding:
      position: 101
      prefix: --max_orthogroup_size
  - id: min_orthogroup_size
    type:
      - 'null'
      - int
    doc: 'Minimum number of sequences in orthogroup alignments (default 4)'
    inputBinding:
      position: 101
      prefix: --min_orthogroup_size
  - id: rooting_order
    type:
      - 'null'
      - File
    doc: 'File with a list of string fragments matching sequence identifiers of species, from older to younger lineages, to root trees (requires raxml)'
    inputBinding:
      position: 101
      prefix: --rooting_order
      valueFrom: $(self.path)
  - id: bootstrap_replicates
    type:
      - 'null'
      - int
    doc: 'Number of replicates for rapid bootstrap analysis (requires raxml), default 100'
    inputBinding:
      position: 101
      prefix: --bootstrap_replicates
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 'number of threads (CPUs) for external utilities (RAxML), default 1'
    inputBinding:
      position: 101
      prefix: --num_threads
outputs:
  - id: phylogenies_dir
    type: Directory
    doc: 'Gene family trees'
    outputBinding:
      glob: 'geneFamilyPhylogenies_dir'
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_gene_family_phylogeny_builder:1.0.4--0
stdout: GeneFamilyPhylogenyBuilder.log
