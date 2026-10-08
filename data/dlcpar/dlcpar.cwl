cwlVersion: v1.2
class: CommandLineTool
baseCommand: dlcpar
label: dlcpar
doc: "dlcpar is a phylogenetic program for finding the most parsimonious gene tree-species
  tree reconciliation by inferring speciation, duplication, loss, and deep coalescence
  events. See http://compbio.mit.edu/dlcpar for details.\n\nTool homepage: https://github.com/wutron/dlcpar"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.gene_tree)
        writable: true
inputs:
  - id: gene_tree
    type:
      type: array
      items: File
    doc: gene tree
    inputBinding:
      position: 1
  - id: allow_both
    type:
      - 'null'
      - boolean
    doc: set to allow duplications on both children
    inputBinding:
      position: 102
      prefix: --allow_both
  - id: coal_cost
    type:
      - 'null'
      - float
    doc: deep coalescence cost
    inputBinding:
      position: 102
      prefix: --coalcost
  - id: dup_cost
    type:
      - 'null'
      - float
    doc: duplication cost
    inputBinding:
      position: 102
      prefix: --dupcost
  - id: input_file_extension
    type:
      - 'null'
      - string
    doc: input file extension
    inputBinding:
      position: 102
      prefix: --inputext
  - id: locus_map
    type:
      - 'null'
      - File
    doc: gene to locus map (species-specific)
    inputBinding:
      position: 102
      prefix: --lmap
  - id: log
    type:
      - 'null'
      - boolean
    doc: if given, output debugging log
    inputBinding:
      position: 102
      prefix: --log
  - id: loss_cost
    type:
      - 'null'
      - float
    doc: loss cost
    inputBinding:
      position: 102
      prefix: --losscost
  - id: max_dups
    type:
      - 'null'
      - int
    doc: 'maximum # of duplications (in each ancestral species), set to -1 for no
      limit'
    inputBinding:
      position: 102
      prefix: --max_dups
  - id: max_loci
    type:
      - 'null'
      - int
    doc: 'maximum # of co-existing loci (in each ancestral species), set to -1 for
      no limit'
    inputBinding:
      position: 102
      prefix: --max_loci
  - id: max_losses
    type:
      - 'null'
      - int
    doc: 'maximum # of losses (in each ancestral species), set to -1 for no limit'
    inputBinding:
      position: 102
      prefix: --max_losses
  - id: no_prescreen
    type:
      - 'null'
      - boolean
    doc: set to disable prescreen of locus maps
    inputBinding:
      position: 102
      prefix: --no_prescreen
  - id: num_reconciliations
    type:
      - 'null'
      - int
    doc: number of uniform samples
    inputBinding:
      position: 102
      prefix: --nsamples
  - id: output_file_extension
    type:
      - 'null'
      - string
    doc: output file extension
    inputBinding:
      position: 102
      prefix: --outputext
  - id: output_format
    type:
      - 'null'
      - string
    doc: specify output format
    inputBinding:
      position: 102
      prefix: --output_format
  - id: prescreen_factor
    type:
      - 'null'
      - float
    doc: prescreen locus maps if (forward) cost exceeds this factor * min 
      (forward) cost
    inputBinding:
      position: 102
      prefix: --prescreen_factor
  - id: prescreen_min
    type:
      - 'null'
      - int
    doc: prescreen locus maps if min (forward) cost exceeds this value
    inputBinding:
      position: 102
      prefix: --prescreen_min
  - id: random_seed
    type:
      - 'null'
      - int
    doc: random number seed
    inputBinding:
      position: 102
      prefix: --seed
  - id: species_map
    type: File
    doc: gene to species map
    inputBinding:
      position: 102
      prefix: --smap
  - id: species_tree
    type: File
    doc: species tree file in newick format
    inputBinding:
      position: 102
      prefix: --stree
outputs:
  - id: reconciliation_files
    type:
      type: array
      items: File
    doc: Reconciliation outputs written beside each gene tree (<tree><output 
      ext>.tree/.recon/.order/.info, or .coal.tree/.coal.recon/.locus.tree/.locus.recon/.daughters
      with --output_format dlcoal, and .log.gz with --log)
    outputBinding:
      glob: '$("*" + (inputs.output_file_extension ? inputs.output_file_extension
        : ".dlcpar") + ".*")'
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dlcpar:1.0--py27_0
stdout: dlcpar.out
